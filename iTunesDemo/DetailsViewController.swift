//
//  DetailsViewController.swift
//  iTunesDemo
//
//  Created by Vladimir Mironiuk on 04.03.2021.
//

import UIKit
import AVKit

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var albumLabel: UILabel!
    @IBOutlet private weak var trackLabel: UILabel!
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var listenButton: UIButton!
    
    private let networkManager = NetworkManager()
    
    var iTunesResult: ItunesResult?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    
    @IBAction func listenAction(_ sender: UIButton) {
        guard let iTunesResult = iTunesResult else {
            return
        }
        
        listenButton.isEnabled = false
        networkManager.download(iTunesResult.trackPreview) { [weak self] response in
            self?.listenButton.isEnabled = true
            switch response.result {
            case .success(let fileURL):
                self?.playTrack(trackUrl: fileURL)
            case .failure(let error):
                self?.showError(with: "Cannot download track: \(error.localizedDescription)")
            }
        }
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
    
    private func playTrack(trackUrl: URL) {
        let playerController = AVPlayerViewController()
        playerController.player = AVPlayer(url: trackUrl)
        playerController.entersFullScreenWhenPlaybackBegins = true
        present(playerController, animated: true, completion: nil)
    }
}
