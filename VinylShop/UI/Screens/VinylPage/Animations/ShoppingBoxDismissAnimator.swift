import UIKit

class ShoppingBoxDismissAnimator: NSObject, AnimatedTransitioning {

    // MARK: - AnimatedTransitioning

    var allAnimators: [UIViewPropertyAnimator] {
        return fadeOutAnimators + fadeInAnimators + [shoppingBoxAnimator, backgroundAnimator].compactMap { $0 }
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let pageController = transitionContext.viewController(forKey: .to)
            .flatMap { $0 as? UINavigationController }
            .flatMap { $0.viewControllers.last as? VinylPageController }

        guard let presenting = pageController,
              let current = transitionContext.viewController(forKey: .from) as? ShoppingBoxController,
              let barView = presenting.barController.view as? ShoppingBarView else {
            transitionContext.complete()
            return
        }

        let containerView = transitionContext.containerView
        let offset = presenting.pageView.barContainerView.frame.minY - current.boxView.boxView.frame.minY
        presenting.barController.view.isHidden = true

        let fadedOutViews = [
            current.boxView.dismissIconView,
            current.boxView.titleLabel,
            current.boxView.topSeparatorView,
            current.boxView.itemsView,
            current.boxView.bottomSeparatorView,
            current.boxView.footerView
        ]

        let fadedOutSnapshotViews: [UIView] = fadedOutViews.compactMap { view in
            let snapshotView = view.snapshotView(afterScreenUpdates: true)
            snapshotView?.frame = view.frame
            return snapshotView
        }

        guard fadedOutSnapshotViews.count == fadedOutViews.count else {
            return
        }

        fadedOutViews.forEach { $0.layer.opacity = 0.0 }
        fadedOutSnapshotViews.forEach { view in
            view.frame = current.boxView.convert(view.frame, from: current.boxView.boxView)
            containerView.addSubview(view)
        }

        backgroundAnimator = makeBackgroundAnimator(view: current.boxView.dimmedBackgroundView)
        fadeOutAnimators = fadedOutSnapshotViews.map { makeFadeOutAnimator(view: $0) }

        let fadedInSnapshotViews: [UIView] = barView.frameControl.subviews.compactMap { view in
            let snapshotView = view.snapshotView(afterScreenUpdates: true)
            snapshotView?.frame = presenting.view.convert(view.frame, from: barView.frameControl)
            return snapshotView
        }

        guard fadedInSnapshotViews.count == barView.frameControl.subviews.count else {
            return
        }

        fadedInSnapshotViews.forEach(containerView.addSubview)
        fadeInAnimators = fadedInSnapshotViews.map { makeFadeInAnimator(view: $0) }

        shoppingBoxAnimator = makeShoppingBoxAnimator(view: current.boxView.boxView, offset: offset)
        shoppingBoxAnimator?.addCompletion { _ in
            presenting.barController.view.isHidden = false
            current.view.removeFromSuperview()
            fadedOutSnapshotViews.forEach { $0.removeFromSuperview() }
            fadedInSnapshotViews.forEach { $0.removeFromSuperview() }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        allAnimators.forEach { $0.startAnimation() }
    }

    // MARK: - Private

    private var shoppingBoxAnimator: UIViewPropertyAnimator?
    private var backgroundAnimator: UIViewPropertyAnimator?
    private var fadeOutAnimators: [UIViewPropertyAnimator] = []
    private var fadeInAnimators: [UIViewPropertyAnimator] = []

    private func makeShoppingBoxAnimator(view: UIView, offset: CGFloat) -> UIViewPropertyAnimator {
        let timingParameters = UISpringTimingParameters(mass: 1, stiffness: 381, damping: 30, initialVelocity: .zero)

        let animator = UIViewPropertyAnimator(duration: duration, timingParameters: timingParameters)
        animator.addAnimations {
            view.center.y += offset
        }

        return animator
    }

    private func makeBackgroundAnimator(view: UIView) -> UIViewPropertyAnimator {
        view.alpha = 1.0

        return UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            view.alpha = 0.0
        }
    }

    private func makeFadeOutAnimator(view: UIView) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            view.alpha = 0.0
            view.center.y += 20
        }
    }

    private func makeFadeInAnimator(view: UIView) -> UIViewPropertyAnimator {
        view.alpha = 0.0
        view.center.y += 20

        return UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            view.alpha = 1.0
            view.center.y -= 20
        }
    }

}
