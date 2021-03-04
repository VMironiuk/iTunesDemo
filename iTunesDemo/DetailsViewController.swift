//
//  DetailsViewController.swift
//  iTunesDemo
//
//  Created by Vladimir Mironiuk on 04.03.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var albumLabel: UILabel!
    @IBOutlet private weak var trackLabel: UILabel!
    @IBOutlet private weak var artworkImageView: UIImageView!
    
    private let networkManager = NetworkManager()
    
    var iTunesResult: ItunesResult?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        guard let iTunesResult = iTunesResult else {
            return
        }
        
        artistLabel.text = iTunesResult.artistName
        albumLabel.text = iTunesResult.collectionName
        trackLabel.text = iTunesResult.trackName
        networkManager.request(iTunesResult.artwork) { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.artworkImageView.image = UIImage(data: data)
            case .failure(let error):
                self?.showError(with: "Cannot fetch artwork: \(error.localizedDescription)")
            }
        }
    }
}
