// This file was generated from JSON Schema using codebeautify, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome6 = try Welcome6(json)

import Foundation

// MARK: - RSS
struct RSS: Codable {
    
    let channel: Channel?
    let version: String?
}

// MARK: - Channel
struct Channel: Codable {
    
    let title, link, description, language, copyright: String?
    let image: Image
    let item: [Item]
}

// MARK: - Image
struct Image: Codable {
    
    let url, title, link, width, height: String?
}

// MARK: - Item
struct Item: Codable {
    
    let title, link, description, pubDate, category, guid: String?
}
