//
//  PagedData.swift
//  BitriseAPI
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

/// A wrapper object which provides a model with additional pagination data
public struct PagedData<T: Decodable> {
    
    // The underlying data
    public var data: T
    // The pagination metadata
    public var pagination: Pagination?
}
