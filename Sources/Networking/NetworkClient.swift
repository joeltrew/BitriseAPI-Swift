//
//  NetworkClient.swift
//  BitriseAPI
//
//  Created by Joel Trew on 10/02/2018.
//

import Foundation

/// Performs network requests and decodes the responses into the requested types
public class NetworkClient {
    
    // URLSession used to perform dataTasks with the server
    var session: URLSession
    
    // JSONDecoder used to decode the response data
    var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    // Creates a new NetworkClient with a given API token
    public init(token: String) {
        
        let config = URLSessionConfiguration.default
        
        var headers = config.httpAdditionalHeaders ?? [AnyHashable: Any]()
        headers["Authorization"] = "token \(token)"
        config.httpAdditionalHeaders = headers
        
        self.session = URLSession(configuration: config)
    }
    
    
    /// Sends a request to the server, and returns the response wrapped in a datacontainer
    ///
    /// Use this method is used on most endpoints on the Bitrise API, which follows a consistant structure where every response is wrapped in a 'data' object
    /// - Parameters:
    ///   - request: A request object conforming to the APIRequest protocol which defines the parameters for a single request
    ///   - completion:  A completion handler which returns with a Result containing a Data Container wrapper holding the request's response type
    func send<Request: APIRequest>(_ request: Request,
                                   completion: @escaping ResultCompletion<DataContainer<Request.ResponseType>>) {
        
        performNetworkRequest(with: request.urlRequest) { (dataResult) in
            
            let decodedResult = dataResult.flatMap({ (data) -> Result<DataContainer<Request.ResponseType>> in
                return Result({ try self.decodeContainedResponse(data: data) })
            })
            
            completion(decodedResult)
        }
    }
    
    /// Sends a request to the server, and returns the response
    ///
    /// Use this method when the server responds without the usual data wrapper structure,
    /// - Parameters:
    ///   - request: A request object conforming to the APIRequest protocol which defines the parameters for a single request
    ///   - completion: A completion handler which returns with a Result containing the requested response type
    func send<Request: APIRequest>(_ request: Request,
                                   completion: @escaping ResultCompletion<Request.ResponseType>) {
        
        performNetworkRequest(with: request.urlRequest) { (dataResult) in
            
            let decodedResult = dataResult.flatMap({ (data) -> Result<Request.ResponseType> in
                return Result({ try self.decodeResponse(data: data) })
            })
            
            completion(decodedResult)
        }
    }
    
    /// Performs a given request
    ///
    /// - Parameters:
    ///   - request: A request object containing the information needed to connect with the server
    ///   - completion: A completion handler which calls when the request is finished, it contains a Result object which will hold JSON data if succesful, otherwise an error
    func performNetworkRequest(with request: URLRequest, completion: @escaping ResultCompletion<Data>) {
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
    
    /// Decodes a standard bitrise server response, in which the model is wrapped in a 'data' object
    ///
    /// - Parameter data: JSON data which needs to be decoded
    /// - Returns: A Data container wrapping the requested response value
    /// - Throws: An error if the JSON could not decode
    func decodeContainedResponse<Response>(data: Data) throws -> DataContainer<Response> {
        
        do {
            
            let decodedResponse = try self.jsonDecoder.decode(APIResponse<Response>.self, from: data)
            
            if let dataInResponse = decodedResponse.data {
                
                return dataInResponse
                
            } else if let message = decodedResponse.message {
                throw NetworkError.server(message: message)
                
            } else {
                throw NetworkError.decoding
            }
            
        } catch let error {
            throw error
        }
    }
    
    /// Decodes JSON data into a Decodable type
    ///
    /// - Parameter data: JSON data which needs decoding
    /// - Returns: An decoded object
    /// - Throws: An error if the JSON could not decode
    func decodeResponse<Response: Decodable>(data: Data) throws -> Response {
        
        do {
            let decoded = try self.jsonDecoder.decode(Response.self, from: data)
            return decoded
            
        } catch let error {
            throw error
        }
    }
    
    
    enum NetworkError: Error {
        
        case noData
        case server(message: String)
        case decoding
    }
}
