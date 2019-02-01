import UIKit

class ShoppingBoxPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: - UIViewControllerAnimatedTransitioning

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // FIXME: Spike solution

        let barController = transitionContext.viewController(forKey: .from)
            .flatMap { $0 as? UINavigationController }
            .flatMap { $0.viewControllers.last as? VinylPageController }
            .map { $0.barController }

        guard let presenting = barController,
              let presented = transitionContext.viewController(forKey: .to) as? ShoppingBoxController else {
            return
        }

        let containerView = transitionContext.containerView
        containerView.addSubview(presented.view)
        presented.view.frame = containerView.bounds
        presented.boxView.dimmedBackgroundView.alpha = 0.0

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            presented.boxView.dimmedBackgroundView.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

}
