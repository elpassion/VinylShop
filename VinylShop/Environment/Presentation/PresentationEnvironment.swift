import UIKit

class PresentationEnvironment {

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Public API

    func present(context: PresentationContext) {
        presentExecutor(context)
    }

    func dismiss(_ controller: UIViewController, animated: Bool) {
        dismissExecutor(controller, animated)
    }

    // MARK: - Testable properties

    lazy var presentExecutor: (PresentationContext) -> Void = { [weak self] context in
        let controller = context.factory()
        controller.modalPresentationStyle = context.presentationStyle
        controller.modalTransitionStyle = context.transitionStyle
        controller.transitioningDelegate = context.transitioningDelegate

        self?.navigationController.viewControllers.last?.present(controller, animated: context.animated)
        self?.activeContexts[controller] = context
    }

    lazy var dismissExecutor: (UIViewController, Bool) -> Void = { [weak self] controller, animated in
        controller.dismiss(animated: animated) {
            self?.activeContexts[controller] = nil
        }
    }

    // MARK: - Private

    private let navigationController: UINavigationController
    private var activeContexts: [UIViewController: PresentationContext] = [:]

}
