//
//  GetBuildsByAppSlugRequest.swift
//  BitriseAPI
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

struct GetBuildsByAppSlugRequest: PagedAPIRequest {
    
    typealias ResponseType = [Build]
    
    var appSlug: String
    
    var endpoint: String {
        return "apps/\(appSlug)/builds"
    }
    
    var filterQuery: BuildFilterQuery?
    
    let httpMethod: HTTPMethod = .get
    
    var body: Data? = nil
    
    var baseUrl: URL
    
    init(baseUrl: URL, appSlug: String, filterQuery: BuildFilterQuery? = nil) {
        self.baseUrl = baseUrl
        self.appSlug = appSlug
        self.filterQuery = filterQuery
    }
    
    func createUrl() -> URL {
        let urlWithEndpoint =  baseUrl.appendingPathComponent(endpoint)
        let urlWithEndpointAndPagingQueries = urlWithPagintionQueries(from: urlWithEndpoint)
        let finalUrl = addFilterQueries(to: urlWithEndpointAndPagingQueries)
        
        return finalUrl
    }
    
    private func addFilterQueries(to url: URL) -> URL {
        if let filterQuery = filterQuery {
            
            let filterQueries = filterQuery.makeQueryItems()
            
            guard var components = URLComponents(string: url.absoluteString) else {
                return url
            }
            
            var queryItems = components.queryItems ?? []
            queryItems.append(contentsOf: filterQueries)
            
            components.queryItems = queryItems
            
            return components.url ?? url
        }
        return url
    }
}


