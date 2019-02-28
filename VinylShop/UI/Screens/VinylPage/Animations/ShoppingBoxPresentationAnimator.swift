import UIKit

class ShoppingBoxPresentationAnimator: NSObject, AnimatedTransitioning {

    // MARK: - AnimatedTransitioning

    var allAnimators: [UIViewPropertyAnimator] {
        return fadeInAnimators + [backgroundAnimator, shoppingBarAnimator, shoppingBoxAnimator].compactMap { $0 }
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.76
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard var context = ShoppingBoxPresentationAnimationContext(transitionContext: transitionContext) else {
            transitionContext.complete()
            return
        }

        context.pageController.barController.view.isHidden = true
        context.shoppingBarSnapshotView.frame = context.pageController.pageView.barContainerView.frame

        let containerView = transitionContext.containerView
        context.shoppingController.view.frame = context.pageController.view.bounds
        containerView.addSubview(context.shoppingController.view)
        containerView.addSubview(context.shoppingBarSnapshotView)

        let boxView: ShoppingBoxView = context.shoppingController.boxView
        boxView.setNeedsLayout()
        boxView.layoutIfNeeded()

        let fadeInDelays = [0.1, 0.25, 0.30, 0.35, 0.40, 0.45]

        zip(context.fadedInViews, context.fadedInSnapshotViews).forEach { view, snapshotView in
            view.alpha = 0.0
            snapshotView.alpha = 0.0
            snapshotView.frame = boxView.convert(view.frame, from: boxView.boxView)
            containerView.addSubview(snapshotView)
        }

        let offset = context.pageController.pageView.barContainerView.frame.minY
            - context.shoppingController.boxView.boxView.frame.minY

        backgroundAnimator = makeBackgroundAnimator(view: context.shoppingController.boxView.dimmedBackgroundView)
        shoppingBarAnimator = makeShoppingBarAnimator(view: context.shoppingBarSnapshotView)
        shoppingBoxAnimator = makeShoppingBoxAnimator(view: context.shoppingController.boxView.boxView, offset: offset)

        fadeInAnimators = zip(context.fadedInSnapshotViews, fadeInDelays).map(makeFadeInAnimator(view:delay:))

        allAnimators.forEach { $0.startAnimation() }

        backgroundAnimator?.addCompletion { _ in
            context.pageController.barController.view.isHidden = false
            context.fadedInViews.forEach { $0.alpha = 1.0 }
            context.fadedInSnapshotViews.forEach { $0.removeFromSuperview() }
            context.shoppingBarSnapshotView.removeFromSuperview()
            transitionContext.complete()
        }
    }

    // MARK: - Private

    private var backgroundAnimator: UIViewPropertyAnimator?
    private var shoppingBarAnimator: UIViewPropertyAnimator?
    private var shoppingBoxAnimator: UIViewPropertyAnimator?
    private var fadeInAnimators: [UIViewPropertyAnimator] = []

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
            UIView.delayedKeyframeAnimation(relativeDuration: 0.3, totalDuration: self.duration, delay: delay) {
                view.center.y -= 20
                view.alpha = 1.0
            }
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

}
