//
//  Pagination.swift
//  BitriseAPI
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

public struct Pagination: Decodable {
    
    var totalItemCount: Int
    var pageItemLimit: Int
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
