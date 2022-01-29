//
//  TrackListLoader.swift
//  iTunesPreview
//
//  Created by Vladimir Mironiuk on 29.01.2022.
//

import Foundation

enum TrackListLoadResult {
    case success([TrackItem])
    case failure(Error)
}

protocol TrackListLoader {
    func load(completion: (TrackListLoadResult) -> Void)
}
