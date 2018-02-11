//
//  App.swift
//  BitriseAPI iOS
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

public struct App: Decodable {
    
    var slug: String
    var title: String
    var projectType: String
    var provider: String
    var repoOwner: String
    var repoUrl: URL
    var repoSlug: String
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
