//
//  BuildFilterQuery.swift
//  BitriseAPI
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

public struct BuildFilterQuery {
    
    public var status: Build.Status?
    
    public var branch: String?
    
    public var pullRequestId: Int?
    
    public var after: Date?
    
    public var before: Date?
    
    public var workflow: String?
    
    public var commitMessage: String?
    
    public var buildNumber: Int?
    
    public init() {}
    
    func makeQueryItems() -> [URLQueryItem] {
        
        var items = [URLQueryItem]()
        
        if let status = status {
            items.append(URLQueryItem(name: "status", value: String(status.rawValue)))
        }
        
        if let branch = branch {
            items.append(URLQueryItem(name: "branch", value: branch))
        }
        
        if let pullRequestId = pullRequestId {
            items.append(URLQueryItem(name: "pull_request_id", value: String(pullRequestId)))
        }
        
        if let after = after {
            items.append(URLQueryItem(name: "after", value: String(after.timeIntervalSince1970)))
        }
        
        if let before = before {
            items.append(URLQueryItem(name: "before", value: String(before.timeIntervalSince1970)))
        }
        
        if let workflow = workflow {
            items.append(URLQueryItem(name: "workflow", value: workflow))
        }
        
        if let commitMessage = commitMessage {
            items.append(URLQueryItem(name: "commit_message", value: commitMessage))
        }
        
        if let buildNumber = buildNumber {
            items.append(URLQueryItem(name: "build_number", value: String(buildNumber)))
        }
        
        return items
    }
}
