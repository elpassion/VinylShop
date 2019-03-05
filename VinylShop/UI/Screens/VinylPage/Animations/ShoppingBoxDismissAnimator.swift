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
        guard var context = ShoppingBoxDismissAnimationContext(transitionContext: transitionContext) else {
            transitionContext.complete()
            return
        }

        let containerView = transitionContext.containerView
        let offset = context.pageController.pageView.barContainerView.frame.minY
            - context.shoppingController.boxView.boxView.frame.minY
        context.pageController.barController.view.isHidden = true

        zip(context.fadedOutViews, context.fadedOutSnapshotViews).forEach { view, snapshotView in
            view.alpha = 0.0
            snapshotView.frame = context.shoppingController.boxView.converted(view)
            containerView.addSubview(snapshotView)
        }

        backgroundAnimator = makeBackgroundAnimator(view: context.shoppingController.boxView.dimmedBackgroundView)
        fadeOutAnimators = context.fadedOutSnapshotViews.map(makeFadeOutAnimator)

        let fadedInSnapshotViews: [UIView] = context.shoppingBarView.frameControl.subviews.compactMap { view in
            let snapshotView = view.snapshotView(afterScreenUpdates: true)
            snapshotView?.frame = context.pageController.view.convert(view.frame, from: context.shoppingBarView.frameControl)
            return snapshotView
        }

        guard fadedInSnapshotViews.count == context.shoppingBarView.frameControl.subviews.count else {
            return
        }

        fadedInSnapshotViews.forEach(containerView.addSubview)
        fadeInAnimators = fadedInSnapshotViews.map { makeFadeInAnimator(view: $0) }

        shoppingBoxAnimator = makeShoppingBoxAnimator(view: context.shoppingController.boxView.boxView, offset: offset)
        shoppingBoxAnimator?.addCompletion { _ in
            context.pageController.barController.view.isHidden = false
            context.shoppingController.view.removeFromSuperview()
            context.fadedOutSnapshotViews.forEach { $0.removeFromSuperview() }
            fadedInSnapshotViews.forEach { $0.removeFromSuperview() }
            transitionContext.complete()
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
