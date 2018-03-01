//
//  Build.swift
//  BitriseAPI
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

/// A model which describes a `Build` of an app in Bitrise
public struct Build: Decodable {
    
    // A unique id of a specific build
    public var slug: String
    // The date/time the build was triggered
    public var triggeredAt: Date
    // The date/time the build was assigned a worker and esentially 'started'
    public var startedOnWorkerAt: Date?
    // The date/time the environment finished preparing
    public var environmentPrepareFinishedAt: Date?
    // The date/time the build finished
    public var finishedAt: Date?
    // The current status of the build
    public var status: Status
    // A reason for why the build was aborted if it was, and one was provided
    public var abortReason: String?
    // If the build is 'on hold' or waiting for other builds to finish before it can start
    public var isOnHold: Bool
    // The git branch the build was triggered from
    public var branch: String
    // The build number of the build
    public var buildNumber: Int
    // The commit hash the build is being created from
    public var commitHash: String?
    
    public var tag: String?
    // Which workflow was triggered with the build
    public var triggeredWorkflow: String
    // Who triggered the build
    public var triggeredBy: String?
    // Details on the computing stack the build was created on
    public var stackConfigType: String?
    // An indentifier to a specific computing stack
    public var stackIdentifier: String?
    // The build parameters that were given when creating the build
    public var originalBuildParams: [String: String]?
    // A pull request id if the build was triggered via pull request
    public var pullRequestId: Int?
    
    public var pullRequestTargetBranch: String?
    
    public var pullRequestViewUrl: URL?
    
    public var commitViewUrl: URL?
    // If the current build is running
    public var isRunning: Bool {
        return ((self.status == Build.Status.unfinished) && (isOnHold == false))
    }
    // The time that it took for the build to finish in seconds
    public var buildTimeInSeconds: Int? {
        
        guard let environmentPrepareFinishedAt = self.environmentPrepareFinishedAt, let finishedAt = self.finishedAt else {
            return nil
        }
        
        return Calendar.current.dateComponents([.second], from: environmentPrepareFinishedAt, to: finishedAt).second
    }
    
    // If the build was successful
    // Note that it is possible to abort a build and it be considered a 'successful build', however the default is failed
    public var wasSuccessful: Bool {
        switch status {
        case .finished(let subStatus):
            return subStatus == .success
        case .aborted(let subStatus):
            return subStatus == .success
        default:
            return false
        }
    }
    
    
    public enum Status: Decodable, Equatable {
        
        case unfinished
        
        case finished(FinishedStatus)
        
        case aborted(FinishedStatus)
        
        case unknown
        
        public var title: String {
            switch self {
            case .unfinished:
                return "Unfinished or Running"
            case .finished(let status):
                return "Finished: \(status.title)"
            case .aborted(let status):
                return "Aborted: \(status.title)"
            case .unknown:
                return "Unknown"
            }
        }
        
        public var rawValue: Int {
            switch self {
            case .unfinished: return 0
            case .finished(.success): return 1
            case .finished(.failed): return 2
            case .aborted(.failed): return 3
            case .aborted(.success): return 4
            default: return 5
            }
        }
        
        public init(rawValue: Int) {
            
            switch rawValue {
            case 0: self = .unfinished
            case 1: self = .finished(.success)
            case 2: self = .finished(.failed)
            case 3: self = .aborted(.failed)
            case 4: self = .aborted(.success)
            default: self = .unknown
            }
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(Int.self)
            self = Status(rawValue: rawValue)
        }
        
        public enum FinishedStatus: Equatable {
            
            case success
            case failed
            
            var title: String {
                switch self {
                    
                case .success:
                    return "Success"
                case .failed:
                    return "Failed"
                }
            }
        }
        
        public static func ==(lhs: Build.Status, rhs: Build.Status) -> Bool {
            switch (lhs, rhs) {
                
            case (.unfinished, .unfinished): return true
                
            case (let .finished(statusA), let .finished(statusB)):
                return statusA == statusB
                
            case (let .aborted(statusA), let .aborted(statusB)):
                return statusA == statusB
                
            case (.unknown, .unknown): return true
                
            default: return false
            }
        }
    }
    
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
