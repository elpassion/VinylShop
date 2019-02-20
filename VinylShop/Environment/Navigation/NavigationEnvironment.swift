import UIKit

class NavigationEnvironment {

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Public API

    func go(to route: Route) {
        _goToRoute(route)
    }

    func goBack() {
        _goBack()
    }

    // MARK: - Testable properties

    lazy var _goToRoute: (Route) -> Void = {
        return { [weak self] route in
            let controller = makeController(for: route)
            let currentStack = self?.navigationController.viewControllers ?? []

            self?.navigationController.setViewControllers(currentStack + [controller], animated: true)
        }
    }()

    lazy var _goBack: () -> Void = {
        return { [weak self] in
            let currentStack = self?.navigationController.viewControllers ?? []
            self?.navigationController.setViewControllers(Array(currentStack.dropLast()), animated: true)
        }
    }()

    // MARK: - Private

    private let navigationController: UINavigationController

}
