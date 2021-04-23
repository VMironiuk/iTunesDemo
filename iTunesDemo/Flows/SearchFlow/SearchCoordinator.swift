protocol SearchResultAction {
    
    func searchResultDidSelect(_ searchResult: ItunesResult?)
}

final class SearchCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    
    private let factory: SearchFlowFactoryProtocol
    
    // MARK: - Lifecycle
    
    init(router: Routable, factory: SearchFlowFactoryProtocol) {
        self.factory = factory
        super.init(router: router)
    }
}

// MARK: - Coordinatable

extension SearchCoordinator: Coordinatable {
    
    func start() {
        guard let searchVC = factory.makeSearchView() as? SearchViewController else {
            fatalError("Cannot instantiate SearchViewController")
        }
        
        searchVC.coordinator = self
        router.push(searchVC, animated: true)
    }
}

// MARK: - SearchResultAction

extension SearchCoordinator: SearchResultAction {
    
    func searchResultDidSelect(_ searchResult: ItunesResult?) {
        guard let trackDetailsVC = factory.makeTrackDetailsView() as? DetailsViewController else {
            fatalError("Cannot instantiate DetailsViewController")
        }
        
        trackDetailsVC.iTunesResult = searchResult
        router.push(trackDetailsVC, animated: true)
    }
}
