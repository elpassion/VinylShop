import UIKit

class NavigationEnvironment: NSObject, UINavigationControllerDelegate {

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
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
            self?.navigationStack.append(route)
            self?.currentAnimationController = makeGoToAnimationController(for: route)

            let controller = makeController(for: route)
            let currentStack = self?.navigationController.viewControllers ?? []
            self?.navigationController.setViewControllers(currentStack + [controller], animated: true)
        }
    }()

    lazy var _goBack: () -> Void = {
        return { [weak self] in
            let route = self?.navigationStack.popLast()
            self?.currentAnimationController = route.flatMap { makeGoBackAnimationController(for: $0) }

            let currentStack = self?.navigationController.viewControllers ?? []
            self?.navigationController.setViewControllers(Array(currentStack.dropLast()), animated: true)
        }
    }()

    // MARK: - UINavigationControllerDelegate

    func navigationController(
            _ navigationController: UINavigationController,
            animationControllerFor operation: UINavigationController.Operation,
            from fromVC: UIViewController,
            to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return currentAnimationController
    }

    // MARK: - Private

    private let navigationController: UINavigationController
    private var navigationStack: [Route] = []
    private var currentAnimationController: UIViewControllerAnimatedTransitioning?

}
