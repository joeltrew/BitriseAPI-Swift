//
//  BitriseService.swift
//  BitriseAPI
//
//  Created by Joel Trew on 10/02/2018.
//

import Foundation

class BitriseService {
    
    var userToken: String
    
    var apiConfig: APIConfig = APIConfig(baseUrl: "api.bitrise.io", version: "v0.1")
    
    var networkClient: NetworkClient
    
    init(userToken: String, networkClient: NetworkClient = NetworkClient()) {
        self.userToken = userToken
        self.networkClient = networkClient
    }
    
    
    func getUser(completion: @escaping ResultCompletion<User>) {
        
        let request = GetUserRequest(baseUrl: apiConfig.url)
        
        networkClient.send(request) { (result) in
            
            completion(result.map({ $0.value }))
        }
    }
}
