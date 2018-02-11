//
//  APIResponse.swift
//  BitriseAPI
//
//  Created by Joel Trew on 10/02/2018.
//

import Foundation

public struct APIResponse<Response: Decodable>: Decodable {

    public let message: String?

    public var data: DataContainer<Response>?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.data = try container.decodeIfPresent(DataContainer<Response>.self, forKey: .data)
        self.data?.pagination = try container.decodeIfPresent(Pagination.self, forKey: .paging)
    }
    
    enum CodingKeys: CodingKey {
        
        case message
        
        case data
        
        case paging
    }
}
