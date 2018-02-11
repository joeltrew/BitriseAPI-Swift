//
//  GetArtifactBySlug.swift
//  BitriseAPI
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

struct GetArtifactBySlug: APIRequest {
    
    typealias ResponseType = Artifact
    
    var appSlug: String
    
    var buildSlug: String
    
    var artifactSlug: String
    
    var endpoint: String {
        return "apps/\(appSlug)/builds/\(buildSlug)/artifacts/\(artifactSlug)"
    }
    
    let httpMethod: HTTPMethod = .get
    
    var body: Data? = nil
    
    var baseUrl: URL
    
    init(baseUrl: URL, appSlug: String, buildSlug: String, artifactSlug: String) {
        self.baseUrl = baseUrl
        self.appSlug = appSlug
        self.buildSlug = buildSlug
        self.artifactSlug = artifactSlug
    }
}
