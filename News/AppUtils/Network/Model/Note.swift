// This file was generated from JSON Schema using codebeautify, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome6 = try Welcome6(json)

import Foundation

// MARK: - Note
struct Note: Codable {
    
    let rss: RSS
}

// MARK: - RSS
struct RSS: Codable {
    
    let channel: Channel
    let xmlnsAtom, xmlnsMedia: String
    let version: String
}

// MARK: - Channel
struct Channel: Codable {
    
    let title: String
    let link: [LinkElement]
    let channelDescription, language, copyright: String
    let image: Image
    let item: [Item]
}

// MARK: - Image
struct Image: Codable {
    
    let url: String
    let title: String
    let link: String
    let width, height: String
}

// MARK: - Item
struct Item: Codable {
    
    let title: String
    let link: String
    let guid: GUID
    let itemDescription: DescriptionUnion
    let content: Content?
    let category: Category
    let pubDate: String
    let source: Source?
}

enum Category: Codable {
    
    case g1
}

// MARK: - Content
struct Content: Codable {
    
    let url: String
    let medium: Medium
    let contentPrefix: Prefix
}

enum Prefix: Codable {
    
    case media
}

enum Medium: Codable {
    case image
}

// MARK: - GUID
struct GUID: Codable {
    
    let isPermaLink: String
    let text: String
}

enum DescriptionUnion: Codable {
    
    case descriptionClass(DescriptionClass)
    case string(String)
}

// MARK: - DescriptionClass
struct DescriptionClass: Codable {
    
    let text, cdata: String
}

// MARK: - Source
struct Source: Codable {
    
    let url: String
    let text: String
}

enum LinkElement: Codable {
    case linkClass(LinkClass)
    case string(String)
}

// MARK: - LinkClass
struct LinkClass: Codable {
    
    let href: String
    let rel, type, linkPrefix: String
}
