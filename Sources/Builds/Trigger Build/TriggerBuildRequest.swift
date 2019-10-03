//
//  TriggerBuildRequest.swift
//  BitriseAPI
//
//  Created by Yuto Mizutani on 2019/09/03.
//

import Foundation

struct TriggerBuildRequest: APIRequest {

    typealias ResponseType = Trigger

    var baseUrl: URL

    var appSlug: String

    var endpoint: String {
        return "apps/\(appSlug)/builds"
    }

    let httpMethod: HTTPMethod = .post

    var body: Data?
}
