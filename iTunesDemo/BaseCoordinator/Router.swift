import UIKit

final class Router {

    // MARK: - Properties

    private let rootController: UINavigationController

    // MARK: - Lifecycle

    init(rootController: UINavigationController) {
        self.rootController = rootController
    }
}

// MARK: - Routable

extension Router: Routable {

    func push(_ module: Presentable, animated: Bool) {
        rootController.pushViewController(module, animated: animated)
    }

    func push(_ module: Presentable) {
        push(module, animated: false)
    }
}
