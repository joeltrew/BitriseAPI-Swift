//
//  AbortBuildRequest.swift
//  BitriseAPI
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

struct AbortBuildRequest: APIRequest {
    
    typealias ResponseType = AbortRequestResponse
    
    var baseUrl: URL
    
    var appSlug: String
    
    var buildSlug: String
    
    var endpoint: String {
        return "apps/\(appSlug)/builds/\(buildSlug)/abort"
    }
    
    let httpMethod: HTTPMethod = .post
    
    var body: Data?
}
