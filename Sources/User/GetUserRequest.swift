//
//  GetUserRequest.swift
//  BitriseAPI
//
//  Created by Joel Trew on 10/02/2018.
//

import Foundation

struct GetUserRequest: APIRequest {

    var endpoint: String = "me"
    
    typealias ResponseType = User
    
    let httpMethod: HTTPMethod = .get
    
    var body: Data? = nil
    
    var baseUrl: URL
    
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
}
