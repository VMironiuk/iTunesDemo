class BaseCoordinator {

    // MARK: - Properties

    private var childCoordinators = [Coordinatable]()

    let router: Routable

    // MARK: - Lifecycle

    init(router: Routable) {
        self.router = router
    }

    // MARK: - Public

    func addChildCoordinator(_ childCoordinator: Coordinatable) {
        for coordinator in childCoordinators where coordinator === childCoordinator {
            return
        }
        childCoordinators.append(childCoordinator)
    }

    func removeChildCoordinator(_ childCoordinator: Coordinatable) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === childCoordinator {
            childCoordinators.remove(at: index)
            return
        }
    }
}
