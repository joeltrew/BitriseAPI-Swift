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
    var slug: String
    // The title of an app
    var title: String
    // ios, android etc,
    // Todo: - Make an enum if we defined list of project types
    var projectType: String
    //Which service hosts the source code for the app i.e github
    var provider: String
    // Name of the owner of the repo
    var repoOwner: String
    // The repo url where the source code can be found
    var repoUrl: URL
    // A name of the repo without the owner namespace `MyCoolApp`
    var repoSlug: String
    // If this app is disabled
    var isDisabled: Bool
    

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
