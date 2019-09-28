//
//  App.swift
//  BitriseAPI iOS
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

/// Model describing a specific `App` in the Bitrise system
public struct App: Decodable {
    
    // Unique Identifer of an app
    public var slug: String
    // The title of an app
    public var title: String
    // ios, android etc,
    // Todo: - Make an enum if we defined list of project types
    public var projectType: String
    //Which service hosts the source code for the app i.e github
    public var provider: String
    // Name of the owner of the repo
    public var repoOwner: String
    // The repo url where the source code can be found
    public var repoUrl: URL
    // A name of the repo without the owner namespace `MyCoolApp`
    public var repoSlug: String
    // If this app is disabled
    public var isDisabled: Bool
    // An avatar url of an app
    public var avatarUrl: URL
    // If this app is public
    public var isPublic: Bool
    // Owner info of an app
    public var owner: Owner
    // The status of the last finished build
    public var status: Int

    public struct Owner: Codable {

        // Account type of owner
        public var accountType: String
        // Owner name
        public var name: String
        // Unique Identifer of owner
        public var slug: String

        private enum CodingKeys: String, CodingKey {
            case accountType = "account_type"
            case name
            case slug
        }
    }

    enum CodingKeys: String, CodingKey {
        case slug
        case title
        case projectType = "project_type"
        case provider
        case repoOwner = "repo_owner"
        case repoUrl = "repo_url"
        case repoSlug = "repo_slug"
        case isDisabled = "is_disabled"
        case avatarUrl = "avatar_url"
        case isPublic = "is_public"
        case owner
        case status
    }
}
