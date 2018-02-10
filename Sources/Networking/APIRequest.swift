//
//  APIRequest.swift
//  BitriseAPI
//
//  Created by Joel Trew on 10/02/2018.
//

import Foundation

import Foundation

protocol APIRequest {
    
    associatedtype Response: Decodable
    
    var urlRequest: URLRequest {
        get
    }
    
    var httpMethod: HTTPMethod {
        get
    }
    
    var headers: [String: String] {
        get
    }
    
    var body: Encodable {
        get
    }
}


enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
    case update = "UPDATE"
    case delete = "DELETE"
}
