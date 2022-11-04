//
//  Batman.swift
//  News
//
//  Created by Josicleison Elves on 13/08/1401 AP.
//

import Foundation

struct Batman: Codable, Hashable {
    
    let Response, Error, totalResults: String?
    let Search: [Search]?
}

struct Search: Codable, Hashable {
    
    let Title, Year, imdbID, `Type`, Poster: String?
}
