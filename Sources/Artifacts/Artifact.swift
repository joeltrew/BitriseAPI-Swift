//
//  Artifact.swift
//  BitriseAPI
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

public struct Artifact: Decodable {
    
    public typealias Bytes = Int
    
    public var title: String
    
    public var type: ArtifactType
    
    public var isPublicPageEnabled: Bool
    
    public var slug: String
    
    public var fileSize: Bytes
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decode(String.self, forKey: .title)
        
        let artifactTypeRawValue = try container.decode(String.self, forKey: .type)
        self.type = ArtifactType(rawValue: artifactTypeRawValue)
        
        self.isPublicPageEnabled = try container.decode(Bool.self, forKey: .isPublicPageEnabled)
        
        self.slug = try container.decode(String.self, forKey: .slug)
        
        self.fileSize = try container.decode(Int.self, forKey: .fileSize)
    }
    
    enum CodingKeys: String, CodingKey {
        
        case title = "title"
        
        case type = "artifact_type"
        
        case isPublicPageEnabled = "is_public_page_enabled"
        
        case slug = "slug"
        
        case fileSize = "file_size_bytes"
    }
    
    public enum ArtifactType {
        
        case file
        case ipa
        case apk
        case other(String)
        
        init(rawValue: String) {
            
            switch rawValue {
                
            case "file": self = .file
            case "ios-ipa": self = .ipa
            case "android-apk": self = .apk
            default: self = .other(rawValue)
                
            }
        }
    }
}
