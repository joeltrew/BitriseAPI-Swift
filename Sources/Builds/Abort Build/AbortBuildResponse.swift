//
//  AbortBuildResponse.swift
//  BitriseAPI
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

public enum AbortRequestResponse: Decodable {
    
    case status(String)
    
    enum CodingKeys: String, CodingKey {
        case status
        case error = "error_msg"
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? values.decode(String.self, forKey: .status) {
            self = .status(value)
            return
        }
        
        if let value = try? values.decode(String.self, forKey: .error) {
            throw AbortError.failed(message: value)
        }
        
        throw AbortError.badData
    }
    
    enum AbortError: Error {
        
        case failed(message: String)
        
        case badData
    }
}
