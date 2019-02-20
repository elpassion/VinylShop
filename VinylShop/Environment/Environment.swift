import UIKit

class Environment {
    static let shared = Environment()

    lazy var navigationController: UINavigationController = {
        let shopController = ShopController(vinyl: .shotDetails)
        let navigationController = UINavigationController(rootViewController: shopController)
        navigationController.navigationBar.isHidden = true

        return navigationController
    }()

    lazy var presentation = PresentationEnvironment(navigationController: navigationController)
}
