import UIKit

class Environment {
    static let shared = Environment()

    lazy var navigationController: UINavigationController = {
        let rootController = VinylPageController(environment: self)
        let navigationController = UINavigationController(rootViewController: rootController)
        navigationController.navigationBar.isHidden = true

        return navigationController
    }()

    lazy var presentation = PresentationEnvironment(navigationController: navigationController)
}
