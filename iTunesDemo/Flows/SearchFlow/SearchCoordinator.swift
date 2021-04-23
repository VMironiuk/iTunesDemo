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
        let searchVC = factory.makeSearchView()
        router.push(searchVC)
    }
}
