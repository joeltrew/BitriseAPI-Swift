//
//  APIResponse.swift
//  BitriseAPI
//
//  Created by Joel Trew on 10/02/2018.
//

import Foundation

/// A model representing a `response` from the bitrise server
/// The response object can currently contain data requested, and message if soemthing goes wrong
public struct APIResponse<Response: Decodable>: Decodable {

    // A message used to describe an error returned from the server
    public let message: String?
    // A decoded model object wrapped in a containing `container` object
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
