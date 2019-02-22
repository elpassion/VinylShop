import UIKit

class Environment {

    static let shared: Environment = Environment()

    lazy var navigationController: UINavigationController = {
        let shopController = ShopController(vinyl: .shotDetails)
        let navigationController = UINavigationController(rootViewController: shopController)
        navigationController.navigationBar.isHidden = true

        return navigationController
    }()

    lazy var presentation: PresentationEnvironment = PresentationEnvironment(navigationController: navigationController)
    lazy var navigation: NavigationEnvironment = NavigationEnvironment(navigationController: navigationController)

    func update(barStyle: UIBarStyle) {
        navigationController.navigationBar.barStyle = barStyle
    }

}
