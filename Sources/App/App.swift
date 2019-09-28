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
    

    enum CodingKeys: String, CodingKey {
        case slug
        case title
        case projectType = "project_type"
        case provider
        case repoOwner = "repo_owner"
        case repoUrl = "repo_url"
        case repoSlug = "repo_slug"
        case isDisabled = "is_disabled"
    }
}
