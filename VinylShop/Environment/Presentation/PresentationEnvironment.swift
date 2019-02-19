import UIKit

class PresentationEnvironment {

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Public API

    func present(context: PresentationContext) {
        _present(context)
    }

    func dismiss(_ controller: UIViewController, animated: Bool) {
        _dismiss(controller, animated)
    }

    // MARK: - Testable properties

    lazy var _present: (PresentationContext) -> Void = {
        return { [weak self] context in
            let controller = context.factory()
            controller.modalPresentationStyle = context.presentationStyle
            controller.modalTransitionStyle = context.transitionStyle
            controller.transitioningDelegate = context.transitioningDelegate

            self?.navigationController.viewControllers.last?.present(controller, animated: context.animated)
            self?.activeContexts[controller] = context
        }
    }()

    lazy var _dismiss: (UIViewController, Bool) -> Void = {
        return { [weak self] controller, animated in
            controller.dismiss(animated: animated) {
                self?.activeContexts[controller] = nil
            }
        }
    }()

    // MARK: - Private

    private let navigationController: UINavigationController
    private var activeContexts: [UIViewController: PresentationContext] = [:]

}
