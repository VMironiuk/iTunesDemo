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
    
    func config(with searchResult: ItunesResult?) {
        artistLabel.text = searchResult?.artistName
        albumLabel.text = searchResult?.collectionName
        trackLabel.text = searchResult?.trackName
    }
}
