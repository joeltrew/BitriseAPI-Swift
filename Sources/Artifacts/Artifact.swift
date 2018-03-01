//
//  Artifact.swift
//  BitriseAPI
//
//  Created by Joel Trew on 11/02/2018.
//

import Foundation

/// Model of a specif Artifact created from a build for example an IPA file for a iOS build, or an APK for an android app
public struct Artifact: Decodable {
    
    public typealias Bytes = Int64
    
    // The title of the artifact
    public var title: String
    // The file type of the artifact
    public var type: ArtifactType
    // If there is a public page to access the artifact
    public var isPublicPageEnabled: Bool
    // The unique is of the artifact
    public var slug: String
    // The filesize of the artifact in bytes
    public var fileSize: Bytes
    // A human readable string for displaying the file size to a user
    var fileSizeDisplay: String {
        return Artifact.byteCountFormatter.string(fromByteCount: self.fileSize)
    }
    
    private static let byteCountFormatter: ByteCountFormatter = {
        let formatter = ByteCountFormatter()
        formatter.isAdaptive = true
        return formatter
    }()
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decode(String.self, forKey: .title)
        
        let artifactTypeRawValue = try container.decode(String.self, forKey: .type)
        self.type = ArtifactType(rawValue: artifactTypeRawValue)
        
        self.isPublicPageEnabled = try container.decode(Bool.self, forKey: .isPublicPageEnabled)
        
        self.slug = try container.decode(String.self, forKey: .slug)
        
        self.fileSize = try container.decode(Int64.self, forKey: .fileSize)
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
