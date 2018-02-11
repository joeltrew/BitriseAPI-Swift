//
//  GetAppBySlugRequest.swift
//  BitriseAPI iOS
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

struct GetAppBySlugRequest: APIRequest {
    
    var endpoint: String = "apps"
    
    typealias ResponseType = App
    
    let httpMethod: HTTPMethod = .get
    
    var baseUrl: URL
    
    var slug: String
    
    init(baseUrl: URL, slug: String) {
        self.baseUrl = baseUrl
        self.slug = slug
    }
    
    func createUrl() -> URL {
        return baseUrl.appendingPathComponent(endpoint).appendingPathComponent(slug)
    }
}
