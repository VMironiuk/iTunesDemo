import Foundation

protocol DetailsPresenterView: class {}

enum DownloadTrackResult {
    case success(URL)
    case failure(Error)
}

enum FetchDataResult {
    case success(Data)
    case failurre(Error)
}

final class DetailsPresenter {
    
    // MARK: - Properties
    
    private let networkManager = NetworkManager()
    
    private let trackDestination: NetworkManager.Destination = { _, _ in
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("track.m4a")
        
        return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
    }
    
    weak var view: DetailsPresenterView?
    
    // MARK: - Lifecycle
    
    init(view: DetailsPresenterView) {
        self.view = view
    }
    
    // MARK: - Public
    
    func downloadTrack(from URLString: String, completion: @escaping (DownloadTrackResult) -> Void) {
        networkManager.download(URLString, to: trackDestination) { response in
            switch response.result {
            case .success(let fileURL):
                completion(.success(fileURL))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func data(from URLString: String, completion: @escaping (FetchDataResult) -> Void) {
        networkManager.request(URLString) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failurre(error))
            }
        }
    }
}
