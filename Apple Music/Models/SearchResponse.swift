//
//  SearchResponse.swift
//  Apple Music
//
//  Created by Yehor Krupiei on 30.07.2023.
//

import Foundation

struct SearchResponse: Codable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Codable {
    var trackName: String
    var collectionName: String?
    var artistName: String
    var posterURL: String?
    var previewUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case trackName
        case collectionName
        case artistName
        case posterURL = "artworkUrl100"
        case previewUrl
    }
}
