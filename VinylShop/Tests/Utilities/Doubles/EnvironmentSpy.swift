@testable import VinylShop
import UIKit

class EnvironmentSpy {

    private(set) var invokedPresent = [PresentationContext]()
    private(set) var invokedDismiss = [(controller: UIViewController, animated: Bool)]()
    private(set) var invokedGoToRoute = [Route]()
    private(set) var invokedGoBackCount = 0
    private var presentExecutor: (PresentationContext) -> Void = Environment.shared.presentation.presentExecutor
    private var dismissExecutor: (UIViewController, Bool) -> Void = Environment.shared.presentation.dismissExecutor
    private var goToRouteExecutor: (Route) -> Void = Environment.shared.navigation.goToRouteExecutor
    private var goBackExecutor: () -> Void = Environment.shared.navigation.goBackExecutor

    // MARK: - Public API

    static let shared = EnvironmentSpy()

    func install() {
        Environment.shared.presentation.presentExecutor = { [weak self] context in
            self?.invokedPresent.append(context)
        }

        Environment.shared.presentation.dismissExecutor = { [weak self] controller, animated in
            self?.invokedDismiss.append((controller: controller, animated: animated))
        }

        Environment.shared.navigation.goToRouteExecutor = { [weak self] route in
            self?.invokedGoToRoute.append(route)
        }

        Environment.shared.navigation.goBackExecutor = { [weak self] in
            self?.invokedGoBackCount += 1
        }
    }

    func uninstall() {
        Environment.shared.presentation.presentExecutor = presentExecutor
        Environment.shared.presentation.dismissExecutor = dismissExecutor
        Environment.shared.navigation.goToRouteExecutor = goToRouteExecutor
        Environment.shared.navigation.goBackExecutor = goBackExecutor
    }

}
