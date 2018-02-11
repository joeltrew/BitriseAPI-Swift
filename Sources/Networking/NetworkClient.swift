//
//  NetworkClient.swift
//  BitriseAPI
//
//  Created by Joel Trew on 10/02/2018.
//

import Foundation

class NetworkClient {
    
    var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
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
                    
                } else if let message = decodedResponse.errorMessage {
                    
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
