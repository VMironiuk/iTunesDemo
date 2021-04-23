import Foundation

protocol SearchPresenterView: class {
    
    func refresh()
    func showErrorMessage(_ message: String)
}

final class SearchPresenter {
    
    // MARK: - Properties
    
    private let baseURL = Config.baseURL
    
    private let networkManager = NetworkManager()
    
    private var itunesResponse: ItunesResponse?
    
    weak var view: SearchPresenterView?
    
    // MARK: - Lifecycle
    
    init(view: SearchPresenterView) {
        self.view = view
    }
    
    // MARK: - Public
    
    func searchTerm(_ term: String) {
        let urlParameters = ["media" : "music", "entity" : "song", "term" : term]
        networkManager.request(baseURL,
                               of: ItunesResponse.self,
                               parameters: urlParameters) { [weak self] response in
            switch response.result {
            case .success(let iTunesResponse):
                self?.itunesResponse = iTunesResponse
                self?.view?.refresh()
            case .failure(let error):
                self?.view?.showErrorMessage(error.localizedDescription)
            }
        }
    }
    
    func results() -> [ItunesResult] {
        itunesResponse?.results ?? []
    }
    
    func countOfResults() -> Int {
        itunesResponse?.results.count ?? 0
    }
    
    func data(from string: String, completion: @escaping (Data?) -> Void) {
        networkManager.request(string) { response in
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure:
                completion(nil)
            }
        }
    }
}
