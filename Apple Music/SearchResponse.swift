//
//  SearchResponse.swift
//  Apple Music
//
//  Created by Yehor Krupiei on 30.07.2023.
//

import Foundation

struct SearchResponse: Decodable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Decodable {
    var trackName: String
    var collectionName: String?
    var artistName: String
    var artworkUrl100: String?
}
