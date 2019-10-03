//
//  Trigger.swift
//  BitriseAPI
//
//  Created by Yuto Mizutani on 2019/09/03.
//

import Foundation

public struct Trigger: Codable {

    public var buildNumber: Int

    public var buildSlug: String

    public var buildUrl: String

    public var message: String

    public var service: String

    public var slug: String

    public var status: String

    public var triggeredWorkflow: String

    private enum CodingKeys: String, CodingKey {

        case buildNumber = "build_number"

        case buildSlug = "build_slug"

        case buildUrl = "build_url"

        case message

        case service

        case slug

        case status

        case triggeredWorkflow = "triggered_workflow"
    }
}
