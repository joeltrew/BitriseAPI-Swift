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
    
    public var startedOnWorkerAt: Date?
    
    public var environmentPrepareFinishedAt: Date?
    
    public var finishedAt: Date?
    
    public var status: Status
    
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
    
    public var isRunning: Bool {
        return ((self.status == Build.Status.unfinished) && (isOnHold == false))
    }
    
    public var buildTimeInSeconds: Int? {
        
        guard let environmentPrepareFinishedAt = self.environmentPrepareFinishedAt, let finishedAt = self.finishedAt else {
            return nil
        }
        
        return Calendar.current.dateComponents([.second], from: environmentPrepareFinishedAt, to: finishedAt).second
    }
    
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
