import Foundation

struct ItunesResponse: Decodable {
    
    let results: [ItunesResult]
}

struct ItunesResult: Decodable {
    
    let artistName: String
    let collectionName: String
    let trackName: String
    let artwork: String
    let trackPreview: String
    
    enum CodingKeys: String, CodingKey {
        
        case artistName
        case collectionName
        case trackName
        case artwork = "artworkUrl100"
        case trackPreview = "previewUrl"
    }
}
