import UIKit

class Environment {
    static let shared = Environment()

    let navigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: VinylPageController())
        navigationController.navigationBar.isHidden = true

        return navigationController
    }()

    lazy var presentation = PresentationEnvironment(navigationController: navigationController)
}
