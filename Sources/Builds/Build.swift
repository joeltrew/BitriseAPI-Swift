//
//  Build.swift
//  BitriseAPI
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

public struct Build: Decodable {
    
    var slug: String
    
    var triggeredAt: Date
    
    var startedOnWorkerAt: Date
    
    var environmentPrepareFinishedAt: Date
    
    var finishedAt: Date
    
    var status: Int
    
    var abortReason: String?
    
    var isOnHold: Bool
    
    var branch: String
    
    var buildNumber: Int
    
    var commitHash: String?
    
    var tag: String?
    
    var triggeredWorkflow: String
    
    var triggeredBy: String?
    
    var stackConfigType: String?
    
    var stackIdentifier: String?
    
    var originalBuildParams: [String: String]?
    
    var pullRequestId: Int?
    
    var pullRequestTargetBranch: String?
    
    var pullRequestViewUrl: URL?
    
    var commitViewUrl: URL?
    
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
