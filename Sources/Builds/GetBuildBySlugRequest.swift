//
//  GetBuildBySlugRequest.swift
//  BitriseAPI
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

struct GetBuildBySlugRequest: APIRequest {
    
    var appSlug: String
    
    var buildSlug: String
    
    var endpoint: String {
        return "apps/\(appSlug)/builds/\(buildSlug)"
    }
    
    typealias ResponseType = Build
    
    let httpMethod: HTTPMethod = .get
    
    var body: Data? = nil
    
    var baseUrl: URL
    
    init(baseUrl: URL, appSlug: String, buildSlug: String) {
        self.baseUrl = baseUrl
        self.appSlug = appSlug
        self.buildSlug = buildSlug
    }
}
