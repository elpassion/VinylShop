import UIKit

class PresentationEnvironment {

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Public API

    func present(context: PresentationContext) {
        _present(context)
    }

    // MARK: - Testable stubs

    lazy var _present: (PresentationContext) -> Void = {
        return { [weak self] context in
            let controller = context.factory()
            controller.modalPresentationStyle = context.presentationStyle
            controller.modalTransitionStyle = context.transitionStyle
            controller.transitioningDelegate = context.transitioningDelegate

            self?.navigationController.viewControllers.last?.present(controller, animated: context.animated)
        }
    }()

    // MARK: - Private

    private let navigationController: UINavigationController

}
