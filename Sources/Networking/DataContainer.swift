//
//  DataContainer.swift
//  BitriseAPI
//
//  Created by Joel Trew on 10/02/2018.
//

import Foundation

public struct DataContainer<WrappedValue: Decodable>: Decodable {
    
    var value: WrappedValue
    
    var pagination: Pagination?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.value = try container.decode(WrappedValue.self)
    }
    
    mutating func providePagination(_ pagination: Pagination) {
        self.pagination = pagination
    }
}
