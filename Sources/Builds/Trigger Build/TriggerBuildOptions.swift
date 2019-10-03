//
//  TriggerBuildOptions.swift
//  BitriseAPI
//
//  Created by Yuto Mizutani on 2019/09/03.
//

import Foundation

public struct TriggerBuildOptions: Codable {

    public let buildParams: BuildParams
    public let hookInfo: HookInfo

    public init(buildParams: BuildParams, hookInfo: HookInfo = HookInfo(type: "bitrise")) {
        self.buildParams = buildParams
        self.hookInfo = hookInfo
    }

    public struct BuildParams: Codable {
        public let branch: String
        public let branchDest: String?
        public let branchDestRepoOwner: String?
        public let branchRepoOwner: String?
        public let buildRequestSlug: String?
        public let commitHash: String?
        public let commitMessage: String?
        public let commitPaths: [CommitPaths]?
        public let diffURL: String?
        public let environments: [Environments]?
        public let pullRequestAuthor: String?
        public let pullRequestHeadBranch: String?
        public let pullRequestID: Int?
        public let pullRequestMergeBranch: String?
        public let pullRequestRepositoryURL: String?
        public let skipGitStatusReport: Bool?
        public let tag: String?
        public let workflowID: String?

        public init(branch: String,
                    branchDest: String? = nil,
                    branchDestRepoOwner: String? = nil,
                    branchRepoOwner: String? = nil,
                    buildRequestSlug: String? = nil,
                    commitHash: String? = nil,
                    commitMessage: String? = nil,
                    commitPaths: [CommitPaths]? = nil,
                    diffURL: String? = nil,
                    environments: [Environments]? = nil,
                    pullRequestAuthor: String? = nil,
                    pullRequestHeadBranch: String? = nil,
                    pullRequestID: Int? = nil,
                    pullRequestMergeBranch: String? = nil,
                    pullRequestRepositoryURL: String? = nil,
                    skipGitStatusReport: Bool? = nil,
                    tag: String? = nil,
                    workflowID: String? = nil) {
            self.branch = branch
            self.branchDest = branchDest
            self.branchDestRepoOwner = branchDestRepoOwner
            self.branchRepoOwner = branchRepoOwner
            self.buildRequestSlug = buildRequestSlug
            self.commitHash = commitHash
            self.commitMessage = commitMessage
            self.commitPaths = commitPaths
            self.diffURL = diffURL
            self.environments = environments
            self.pullRequestAuthor = pullRequestAuthor
            self.pullRequestHeadBranch = pullRequestHeadBranch
            self.pullRequestID = pullRequestID
            self.pullRequestMergeBranch = pullRequestMergeBranch
            self.pullRequestRepositoryURL = pullRequestRepositoryURL
            self.skipGitStatusReport = skipGitStatusReport
            self.tag = tag
            self.workflowID = workflowID
        }

        public struct CommitPaths: Codable {

            public let added: [String]
            public let modified: [String]
            public let removed: [String]

            public init(added: [String],
                        modified: [String],
                        removed: [String]) {
                self.added = added
                self.modified = modified
                self.removed = removed
            }
        }

        public struct Environments: Codable {

            public let isExpand: Bool
            public let mappedTo: String
            public let value: String

            public init(isExpand: Bool,
                        mappedTo: String,
                        value: String) {
                self.isExpand = isExpand
                self.mappedTo = mappedTo
                self.value = value
            }

            private enum CodingKeys: String, CodingKey {
                case isExpand = "is_expand"
                case mappedTo = "mapped_to"
                case value
            }
        }

        private enum CodingKeys: String, CodingKey {
            case branch
            case branchDest = "branch_dest"
            case branchDestRepoOwner = "branch_dest_repo_owner"
            case branchRepoOwner = "branch_repo_owner"
            case buildRequestSlug = "build_request_slug"
            case commitHash = "commit_hash"
            case commitMessage = "commit_message"
            case commitPaths = "commit_paths"
            case diffURL = "diff_url"
            case environments
            case pullRequestAuthor = "pull_request_author"
            case pullRequestHeadBranch = "pull_request_head_branch"
            case pullRequestID = "pull_request_id"
            case pullRequestMergeBranch = "pull_request_merge_branch"
            case pullRequestRepositoryURL = "pull_request_repository_url"
            case skipGitStatusReport = "skip_git_status_report"
            case tag
            case workflowID = "workflow_id"
        }
    }

    public struct HookInfo: Codable {

        public let type: String

        public init(type: String) {
            self.type = type
        }
    }

    private enum CodingKeys: String, CodingKey {
        case buildParams = "build_params"
        case hookInfo = "hook_info"
    }
}
