//
//  Build.swift
//  BitriseAPI
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

public struct Build: Decodable {
    
    public var slug: String
    
    public var triggeredAt: Date
    
    public var startedOnWorkerAt: Date
    
    public var environmentPrepareFinishedAt: Date
    
    public var finishedAt: Date
    
    public var status: Int
    
    public var abortReason: String?
    
    public var isOnHold: Bool
    
    public var branch: String
    
    public var buildNumber: Int
    
    public var commitHash: String?
    
    public var tag: String?
    
    public var triggeredWorkflow: String
    
    public var triggeredBy: String?
    
    public var stackConfigType: String?
    
    public var stackIdentifier: String?
    
    public var originalBuildParams: [String: String]?
    
    public var pullRequestId: Int?
    
    public var pullRequestTargetBranch: String?
    
    public var pullRequestViewUrl: URL?
    
    public var commitViewUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        
        case slug = "slug"
        case triggeredAt = "triggered_at"
        case startedOnWorkerAt = "started_on_worker_at"
        case environmentPrepareFinishedAt = "environment_prepare_finished_at"
        case finishedAt = "finished_at"
        case status = "status"
        case abortReason = "abort_reason"
        case isOnHold = "is_on_hold"
        case branch = "branch"
        case buildNumber = "build_number"
        case commitHash = "commit_hash"
        case tag = "tag"
        case triggeredWorkflow = "triggered_workflow"
        case triggeredBy = "triggered_by"
        case stackConfigType = "stack_config_type"
        case stackIdentifier = "stack_identifier"
        case originalBuildParams = "original_build_params"
        case pullRequestId = "pull_request_id"
        case pullRequestTargetBranch = "pull_request_target_branch"
        case pullRequestViewUrl = "pull_request_view_url"
        case commitViewUrl = "commit_view_url"
    }
}
