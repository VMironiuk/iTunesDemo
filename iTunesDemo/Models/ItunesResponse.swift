//
//  ItunesResponse.swift
//  iTunesDemo
//
//  Created by Vladimir Mironiuk on 03.03.2021.
//

import Foundation

struct ItunesResponse: Decodable {
    
    let results: [ItunesResult]
}

struct ItunesResult: Decodable {
    
    let artistName: String
    let collectionName: String
    let trackName: String
    let artworkMiniature: String
    
    enum CodingKeys: String, CodingKey {
        
        case artistName
        case collectionName
        case trackName
        case artworkMiniature = "artworkUrl100"
    }
}
