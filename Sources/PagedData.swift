//
//  PagedData.swift
//  BitriseAPI
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

public struct PagedData<T: Decodable> {
    
    public var data: T
    
    public var pagination: Pagination?
}
