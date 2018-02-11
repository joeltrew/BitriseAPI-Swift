//
//  APIResponse.swift
//  BitriseAPI
//
//  Created by Joel Trew on 10/02/2018.
//

import Foundation

public struct APIResponse<Response: Decodable>: Decodable {

    public let message: String?
    
    public var pagination: Pagination?

    public var data: DataContainer<Response>?
    
    public struct Pagination: Decodable {
        
        var totalItemCount: Int
        var pageItemLimit: Int
        var next: String?
    }
}
