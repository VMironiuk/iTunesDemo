import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private var coordinator: Coordinatable?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        let rootController = UINavigationController()
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = rootController
        window?.rootViewController?.view.backgroundColor = .systemTeal
        window?.makeKeyAndVisible()

        let router = Router(rootController: rootController)
        let factory = CoordinatorsFactory()
        coordinator = AppCoordinator(router: router, factory: factory)
        coordinator?.start()
    }
}

