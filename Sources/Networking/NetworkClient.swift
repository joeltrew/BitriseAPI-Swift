//
//  NetworkClient.swift
//  BitriseAPI
//
//  Created by Joel Trew on 10/02/2018.
//

import Foundation

public class NetworkClient {
    
    var session: URLSession
    
    public init(token: String) {
        let config = URLSessionConfiguration.default
        var headers = config.httpAdditionalHeaders ?? [AnyHashable: Any]()
        headers["Authorization"] = "token \(token)"
        config.httpAdditionalHeaders = headers
        self.session = URLSession(configuration: config)
        
    }
    
    
    
    func send<Request: APIRequest>(_ request: Request,
                                   completion: @escaping ResultCompletion<DataContainer<Request.Response>>) {
        
        
       let task = session.dataTask(with: request.urlRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                
                let decodedResponse = try JSONDecoder().decode(APIResponse<Request.Response>.self, from: data)
                
                if let dataInResponse = decodedResponse.data {
                    
                    completion(.success(dataInResponse))
                    return
                    
                } else if let message = decodedResponse.message {
                    
                    completion(.failure(NetworkError.server(message: message)))
                    return
                    
                } else {
                    completion(.failure(NetworkError.decoding))
                    return
                }
        
                
            } catch let error {
                completion(.failure(error))
                return
            }
        }
        
        task.resume()
    }
    
    
    
    enum NetworkError: Error {
        
        case noData
        case server(message: String)
        case decoding
    }
}
