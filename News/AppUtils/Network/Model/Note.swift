// This file was generated from JSON Schema using codebeautify, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome6 = try Welcome6(json)

import Foundation

// MARK: - RSS
struct RSS: Codable {
    
    let channel: Channel?
}

// MARK: - Channel
struct Channel: Codable {
    
    let title: String?
    let link: String?
    let description, language, copyright: String?
}
