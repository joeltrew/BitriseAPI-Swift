//
//  BitriseService.swift
//  BitriseAPI
//
//  Created by Joel Trew on 10/02/2018.
//

import Foundation

public class BitriseService {
    
    var userToken: String
    
    var apiConfig: APIConfig = APIConfig(baseUrl: "api.bitrise.io", version: "v0.1")
    
    var networkClient: NetworkClient
    
    public init(userToken: String) {
        self.userToken = userToken
        self.networkClient = NetworkClient(token: userToken)
    }
    
    
    public func getUser(completion: @escaping ResultCompletion<User>) {
        
        let request = GetUserRequest(baseUrl: apiConfig.url)
        
        networkClient.send(request) { (result) in
            
            completion(result.map({ $0.value }))
        }
    }
}
