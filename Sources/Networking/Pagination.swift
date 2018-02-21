//
//  Pagination.swift
//  BitriseAPI
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

/// An object which contains data about the current pagination state of a response, for example the currentpage and the total number of items
public struct Pagination: Decodable {
    
    // The total number of items available
    var totalItemCount: Int
    // The number of items appearing per page
    var pageItemLimit: Int
    // An id which provides the next page of results
    var next: String?
    
    public init(pageItemLimit: Int, next: String?) {
        self.totalItemCount = 0
        self.pageItemLimit = pageItemLimit
        self.next = next
    }
    
    enum CodingKeys: String, CodingKey {
        
        case totalItemCount = "total_item_count"
        
        case pageItemLimit = "page_item_limit"
        
        case next
    }
}
