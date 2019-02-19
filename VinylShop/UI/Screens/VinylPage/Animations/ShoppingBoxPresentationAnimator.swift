import UIKit

class ShoppingBoxPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: - UIViewControllerAnimatedTransitioning

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.76
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // FIXME: Spike solution
        let pageController = transitionContext.viewController(forKey: .from)
            .flatMap { $0 as? UINavigationController }
            .flatMap { $0.viewControllers.last as? VinylPageController }

        guard let current = pageController,
              let presenting = transitionContext.viewController(forKey: .to) as? ShoppingBoxController,
              let barSnapshot = current.barController.view.snapshotView(afterScreenUpdates: true) else {
            return
        }

        current.barController.view.isHidden = true
        barSnapshot.frame = current.pageView.barContainerView.frame

        let containerView = transitionContext.containerView
        presenting.view.frame = current.view.bounds
        containerView.addSubview(presenting.view)
        containerView.addSubview(barSnapshot)

        let boxView: ShoppingBoxView = presenting.boxView
        boxView.setNeedsLayout()
        boxView.layoutIfNeeded()

        let fadedInViews = [
            boxView.dismissIconView,
            boxView.titleLabel,
            boxView.topSeparatorView,
            boxView.itemsView,
            boxView.bottomSeparatorView,
            boxView.footerView
        ]

        let fadeInDelays = [0.1, 0.25, 0.30, 0.35, 0.40, 0.45]
        let snapshotViews: [UIView] = fadedInViews.compactMap { view in
            let snapshotView = view.snapshotView(afterScreenUpdates: true)
            snapshotView?.frame = view.frame
            return snapshotView
        }

        guard snapshotViews.count == fadedInViews.count else {
            return
        }

        fadedInViews.forEach { $0.layer.opacity = 0.0 }
        snapshotViews.forEach { view in
            view.layer.opacity = 0.0
            view.frame = boxView.convert(view.frame, from: boxView.boxView)
            containerView.addSubview(view)
        }

        let offset = current.pageView.barContainerView.frame.minY - presenting.boxView.boxView.frame.minY

        backgroundAnimator = makeBackgroundAnimator(view: presenting.boxView.dimmedBackgroundView)
        shoppingBarAnimator = makeShoppingBarAnimator(view: barSnapshot)
        shoppingBoxAnimator = makeShoppingBoxAnimator(view: presenting.boxView.boxView, offset: offset)

        fadeInAnimators = (0..<fadedInViews.count).map { index in
            makeFadeInAnimator(view: snapshotViews[index], delay: fadeInDelays[index])
        }

        allAnimators.forEach { $0.startAnimation() }

        backgroundAnimator?.addCompletion { _ in
            current.barController.view.isHidden = false
            fadedInViews.forEach { $0.layer.opacity = 1.0 }
            snapshotViews.forEach { $0.removeFromSuperview() }
            barSnapshot.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

    // MARK: - Private

    private var backgroundAnimator: UIViewPropertyAnimator?
    private var shoppingBarAnimator: UIViewPropertyAnimator?
    private var shoppingBoxAnimator: UIViewPropertyAnimator?
    private var fadeInAnimators = [UIViewPropertyAnimator]()

    private var allAnimators: [UIViewPropertyAnimator] {
        return fadeInAnimators + [backgroundAnimator, shoppingBarAnimator, shoppingBoxAnimator].compactMap { $0 }
    }

    private func makeBackgroundAnimator(view: UIView) -> UIViewPropertyAnimator {
        view.alpha = 0.0

        return UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            view.alpha = 1.0
        }
    }

    private func makeShoppingBarAnimator(view: UIView) -> UIViewPropertyAnimator {
        view.alpha = 1.0

        return UIViewPropertyAnimator(duration: duration * 0.3, curve: .easeInOut) {
            view.center.y += 50
            view.alpha = 0.0
        }
    }

    private func makeFadeInAnimator(view: UIView, delay: Double) -> UIViewPropertyAnimator {
        view.alpha = 0.0
        view.center.y += 20

        return UIViewPropertyAnimator(duration: duration, curve: .easeInOut) { [unowned self] in
            let startTime = delay / self.duration
            UIView.animateKeyframes(withDuration: self.duration, delay: 0.0, animations: {
                UIView.addKeyframe(withRelativeStartTime: startTime, relativeDuration: 0.3) {
                    view.center.y -= 20
                    view.alpha = 1.0
                }
            })
        }
    }

    private func makeShoppingBoxAnimator(view: UIView, offset: CGFloat) -> UIViewPropertyAnimator {
        let timingParameters = UISpringTimingParameters(mass: 1, stiffness: 200, damping: 18, initialVelocity: .zero)
        view.center.y += offset

        let animator = UIViewPropertyAnimator(duration: duration, timingParameters: timingParameters)
        animator.addAnimations {
            view.center.y -= offset
        }

        return animator
    }

    private var duration: Double {
        return transitionDuration(using: nil)
    }

}
