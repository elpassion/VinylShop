import UIKit

class UIViewControllerContextTransitioningSpy: NSObject, UIViewControllerContextTransitioning {

    var stubbedViewControllerFrom: UIViewController?
    var stubbedViewControllerTo: UIViewController?

    private(set) var invokedCompleteWith: Bool?

    // MARK: - UIViewControllerContextTransitioning

    var containerView: UIView = UIView(frame: .zero)
    var isAnimated: Bool = false
    var isInteractive: Bool = false
    var transitionWasCancelled: Bool = false
    var presentationStyle: UIModalPresentationStyle = .custom
    var targetTransform: CGAffineTransform = .identity

    func updateInteractiveTransition(_ percentComplete: CGFloat) {}

    func finishInteractiveTransition() {}

    func cancelInteractiveTransition() {}

    func pauseInteractiveTransition() {}

    func completeTransition(_ didComplete: Bool) {
        invokedCompleteWith = didComplete
    }

    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        if key == .from {
            return stubbedViewControllerFrom
        } else if key == .to {
            return stubbedViewControllerTo
        } else {
            return nil
        }
    }

    func view(forKey key: UITransitionContextViewKey) -> UIView? {
        return nil
    }

    func initialFrame(for vc: UIViewController) -> CGRect {
        return .zero
    }

    func finalFrame(for vc: UIViewController) -> CGRect {
        return .zero
    }

}
