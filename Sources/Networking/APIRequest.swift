//
//  APIRequest.swift
//  BitriseAPI
//
//  Created by Joel Trew on 10/02/2018.
//

import Foundation

protocol APIRequest {
    
    associatedtype Response: Decodable
    
    var baseUrl: URL {
        get
    }
    
    var urlRequest: URLRequest {
        get
    }
    
    var httpMethod: HTTPMethod {
        get
    }
    
    var headers: [String: String] {
        get
    }
    
    var body: Data? {
        get
        set
    }
    
    var isAuthenticated: Bool {
        get
    }
}

extension APIRequest {
    
    var urlRequest: URLRequest {
        
        var urlRequest = URLRequest(url: baseUrl)
        
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = body
        urlRequest.allHTTPHeaderFields = headers
        
        return urlRequest
    }
    
    var headers: [String: String] {
        return [String:String]()
    }
    
    var isAuthenticated: Bool {
        return true
    }
    
    mutating func setBody<T: Encodable>(with encodable: T) {
        self.body = try? JSONEncoder().encode(encodable.self)
    }
}


enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
    case update = "UPDATE"
    case delete = "DELETE"
}
