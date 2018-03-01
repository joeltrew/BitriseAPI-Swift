//
//  AbortBuildoptions.swift
//  BitriseAPI
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

public struct AbortBuildOptions: Encodable {
    
    var reason: String
    
    var shouldAbortWithSuccess: Bool
    
    var shouldSkipNotifications: Bool
    
    public init(reason: String, shouldAbortWithSuccess: Bool = false, shouldSkipNotifications: Bool = false) {
        self.reason = reason
        self.shouldAbortWithSuccess = shouldAbortWithSuccess
        self.shouldSkipNotifications = shouldSkipNotifications
    }
    
    enum CodingKeys: String, CodingKey {
        
        case reason = "abort_reason"
        
        case shouldAbortWithSuccess = "abort_with_success"
        
        case shouldSkipNotifications = "skip_notifications"
        
    }
}
