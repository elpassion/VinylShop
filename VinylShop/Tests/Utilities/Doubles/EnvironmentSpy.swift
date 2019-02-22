@testable import VinylShop
import UIKit

class EnvironmentSpy {

    private(set) var invokedPresent = [PresentationContext]()
    private(set) var invokedDismiss = [(controller: UIViewController, animated: Bool)]()
    private(set) var invokedGoToRoute = [Route]()
    private(set) var invokedGoBackCount = 0
    private var _present: (PresentationContext) -> Void = Environment.shared.presentation._present
    private var _dismiss: (UIViewController, Bool) -> Void = Environment.shared.presentation._dismiss
    private var _goToRoute: (Route) -> Void = Environment.shared.navigation._goToRoute
    private var _goBack: () -> Void = Environment.shared.navigation._goBack

    // MARK: - Public API

    static let shared = EnvironmentSpy()

    func install() {
        Environment.shared.presentation._present = { [weak self] context in
            self?.invokedPresent.append(context)
            let optional: Int? = nil
            optional!
        }

        Environment.shared.presentation._dismiss = { [weak self] controller, animated in
            self?.invokedDismiss.append((controller: controller, animated: animated))
        }

        Environment.shared.navigation._goToRoute = { [weak self] route in
            self?.invokedGoToRoute.append(route)
        }

        Environment.shared.navigation._goBack = { [weak self] in
            self?.invokedGoBackCount += 1
        }
    }

    func uninstall() {
        Environment.shared.presentation._present = _present
        Environment.shared.presentation._dismiss = _dismiss
        Environment.shared.navigation._goToRoute = _goToRoute
        Environment.shared.navigation._goBack = _goBack
    }

}
