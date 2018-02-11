//
//  GetAppsRequest.swift
//  BitriseAPI iOS
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

struct GetAppsRequest: APIRequest, PagedAPIRequest {
    
    var limit: Int? = nil
    
    var next: String? = nil
    
    var endpoint: String? = "me/apps"
    
    typealias ResponseType = [App]
    
    let httpMethod: HTTPMethod = .get
    
    var body: Data? = nil
    
    var baseUrl: URL
    
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
}
