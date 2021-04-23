import UIKit
import AVKit

class DetailsViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var albumLabel: UILabel!
    @IBOutlet private weak var trackLabel: UILabel!
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var listenButton: UIButton!

    private lazy var presenter = DetailsPresenter(view: self)

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
        presenter.downloadTrack(from: iTunesResult.trackPreview) { [weak self] result in
            self?.listenButton.isEnabled = true
            switch result {
            case .success(let url):
                self?.playTrack(trackUrl: url)
            case .failure(let error):
                self?.showError(with: R.string.localizable.detailsViewTrackLoadingErrorMessage(
                                    error.localizedDescription))
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

        presenter.data(from: iTunesResult.artwork) { [weak self] result in
            switch result {
            case .success(let data):
                self?.artworkImageView.image = UIImage(data: data)
            case .failurre(let error):
                self?.showError(with: R.string.localizable.detailsViewArtworkLoadingErrorMessage(
                                    error.localizedDescription))
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

// MARK: - DetailsPresenterView

extension DetailsViewController: DetailsPresenterView {}
