final class AppCoordinator: BaseCoordinator {

    // MARK: - Properties

    private let factory: CoordinatorsFactoryProtocol

    // MARK: - Lifecycle

    init(router: Routable, factory: CoordinatorsFactoryProtocol) {
        self.factory = factory
        super.init(router: router)
    }
}

// MARK: - Coordinatable

extension AppCoordinator: Coordinatable {

    func start() {
        performSearchFlow()
    }
}

// MARK: - Private

extension AppCoordinator {

    private func performSearchFlow() {
        let searchCoordinator = factory.makeSearchCoordinator(with: router)
        addChildCoordinator(searchCoordinator)
        searchCoordinator.start()
    }
}
