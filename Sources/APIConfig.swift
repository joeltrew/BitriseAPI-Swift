//
//  APIConfig.swift
//  BitriseAPI
//
//  Created by Joel Trew on 10/02/2018.
//

import Foundation

struct APIConfig {
    
    var baseUrl: String
    
    var version: String
    
    var url: URL {
        
        var components = URLComponents()
        components.host = "https"
        components.host = baseUrl
        components.path = "v\(version)"
    
        guard let url = components.url else {
            fatalError("Can't create url from config")
        }
        
        return url
    }
}
