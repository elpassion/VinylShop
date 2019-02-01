@testable import VinylShop
import UIKit

class EnvironmentSpy {

    private(set) var invokedPresent = [PresentationContext]()
    private(set) var invokedDismiss = [(controller: UIViewController, animated: Bool)]()
    private var _present: (PresentationContext) -> Void = Environment.shared.presentation._present
    private var _dismiss: (UIViewController, Bool) -> Void = Environment.shared.presentation._dismiss

    // MARK: - Public API

    static let shared = EnvironmentSpy()

    func install() {
        Environment.shared.presentation._present = { [weak self] context in
            self?.invokedPresent.append(context)
        }

        Environment.shared.presentation._dismiss = { [weak self] controller, animated in
            self?.invokedDismiss.append((controller: controller, animated: animated))
        }
    }

    func uninstall() {
        Environment.shared.presentation._present = _present
        Environment.shared.presentation._dismiss = _dismiss
    }

}
