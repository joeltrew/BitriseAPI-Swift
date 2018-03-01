//
//  BuildFilterQuery.swift
//  BitriseAPI
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

/// Encapuslates a variety of filter options that can be used to filter the build endpoint
/// All properties on this object are optional, and as few or as many can be provided when initialised, the more properties defined the more specific the uery will be
public struct BuildFilterQuery {
    
    // Filters builds by current status of the build, failed, aborted, success
    public var status: Build.Status?
    
    // Filters builds by git branch the build was started from
    public var branch: String?
    
    // Filters builds by the pull request id the build was created from
    public var pullRequestId: Int?
    
    // Filters builds that were created after a certain date
    public var after: Date?
    
    // Filters builds that were created before a certain date
    public var before: Date?
    
    // Filters builds by the workflow they were triggered with
    public var workflow: String?
    
    // Filters builds by a commit message
    // this string can be a partial match
    public var commitMessage: String?
    
    // Filters build by a specific build number
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
