//
//  PagedAPIRequest.swift
//  BitriseAPI
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

/// Describes the additional parameters needed when requesting data that is returned as pages
protocol PagedAPIRequest: APIRequest {
    
    var limit: Int? {
        get set
    }
    
    var next: String? {
        get set
    }
}

extension PagedAPIRequest {
    func createUrl() -> URL {
        let urlWithEndpoint =  baseUrl.appendingPathComponent(endpoint)
        let urlWithEndpointAndQueries = urlWithPagintionQueries(from: urlWithEndpoint)
        return urlWithEndpointAndQueries
    }
}

extension PagedAPIRequest {
    
    var limit: Int? {
        get {
            return nil
        }
        set {}
    }
    
    var next: String? {
        get {
            return nil
        }
        set {}
    }
    
    func urlWithPagintionQueries(from url: URL) -> URL {
        
        guard self.limit != nil || self.next != nil else {
            return url
        }
        
        guard var components = URLComponents(string: url.absoluteString) else {
            return url
        }
        
        var queryItems = [URLQueryItem]()
        if let limit = self.limit {
            queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
        }
        
        if let next = self.next {
            queryItems.append(URLQueryItem(name: "next", value: next))
        }
        
        components.queryItems = queryItems
        
        return components.url ?? url
    }
}
