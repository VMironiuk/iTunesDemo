//
//  ResultCellTableViewCell.swift
//  iTunesDemo
//
//  Created by Vladimir Mironiuk on 02.03.2021.
//

import UIKit

class ResultCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet private weak var artwork: UIImageView!
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var albumLabel: UILabel!
    @IBOutlet private weak var trackLabel: UILabel!
    
    // MARK: - Public
    
    func config(with searchResult: SearchResult) {
        artwork.image = searchResult.artwork
        artistLabel.text = searchResult.artist
        albumLabel.text = searchResult.album
        trackLabel.text = searchResult.track
    }
}
