//
//  DataContainer.swift
//  BitriseAPI
//
//  Created by Joel Trew on 10/02/2018.
//

import Foundation

/// The datacontainer struct acts as a wrapper around all models returned from the server, it can contain extra metadata about the model such as pagination
public struct DataContainer<WrappedValue: Decodable>: Decodable {
    
    // The underlying wrapped data, this is decodable and is created from json
    var value: WrappedValue
    // Pagination metadata
    var pagination: Pagination?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.value = try container.decode(WrappedValue.self)
    }
    
    mutating func providePagination(_ pagination: Pagination) {
        self.pagination = pagination
    }
}
