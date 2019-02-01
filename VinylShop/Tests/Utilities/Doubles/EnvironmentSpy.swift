@testable import VinylShop

class EnvironmentSpy {

    private(set) var invokedPresent = [PresentationContext]()
    private var _present: (PresentationContext) -> Void = Environment.shared.presentation._present

    // MARK: - Public API

    static let shared = EnvironmentSpy()

    func install() {
        Environment.shared.presentation._present = { [weak self] context in
            self?.invokedPresent.append(context)
        }
    }

    func uninstall() {
        Environment.shared.presentation._present = _present
    }

}
