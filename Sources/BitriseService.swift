//
//  BitriseService.swift
//  BitriseAPI
//
//  Created by Joel Trew on 10/02/2018.
//

import Foundation

class BitriseService {
    
    var userToken: String
    
    var networkClient: NetworkClient
    
    
    init(userToken: String, networkClient: NetworkClient = NetworkClient()) {
        self.userToken = userToken
        self.networkClient = networkClient
    }
}
