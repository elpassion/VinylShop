import UIKit

class ShoppingBoxPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: - UIViewControllerAnimatedTransitioning

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // FIXME: Spike solution

        let pageController = transitionContext.viewController(forKey: .from)
            .flatMap { $0 as? UINavigationController }
            .flatMap { $0.viewControllers.last as? VinylPageController }

        guard let presenting = pageController,
              let presented = transitionContext.viewController(forKey: .to) as? ShoppingBoxController,
              let barSnapshot = presenting.barController.view.snapshotView(afterScreenUpdates: true) else {
            return
        }

        presenting.barController.view.isHidden = true
        barSnapshot.frame = presenting.pageView.barContainerView.frame

        let containerView = transitionContext.containerView
        presented.view.frame = containerView.bounds
        containerView.addSubview(presented.view)
        containerView.addSubview(barSnapshot)
        presented.boxView.dimmedBackgroundView.alpha = 0.0

        presented.boxView.setNeedsLayout()
        presented.boxView.layoutIfNeeded()
        presented.boxView.boxView.subviews.forEach { $0.layer.opacity = 0.0 }

        let duration = transitionDuration(using: transitionContext)

        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)
        CATransaction.setCompletionBlock {
            presented.boxView.boxView.subviews.forEach {
                $0.layer.opacity = 1.0
            }

            presenting.barController.view.isHidden = false
            barSnapshot.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        let backgroundAnimation = CABasicAnimation(keyPath: "opacity")
        backgroundAnimation.fromValue = 0.0
        backgroundAnimation.toValue = 1.0
        backgroundAnimation.duration = duration * 0.5
        backgroundAnimation.isRemovedOnCompletion = true
        presented.boxView.dimmedBackgroundView.layer.add(backgroundAnimation, forKey: nil)
        presented.boxView.dimmedBackgroundView.layer.opacity = 1.0

        let barSnapshotAnimation = CABasicAnimation(keyPath: "position.y")
        barSnapshotAnimation.byValue = 50
        barSnapshotAnimation.duration = duration * 0.5
        barSnapshotAnimation.isRemovedOnCompletion = true
        barSnapshot.layer.position.y = barSnapshot.layer.position.y + 50

        let barSnapshotAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        barSnapshotAlphaAnimation.fromValue = 1.0
        barSnapshotAlphaAnimation.toValue = 0.0
        barSnapshotAlphaAnimation.duration = duration * 0.5
        barSnapshotAlphaAnimation.isRemovedOnCompletion = true
        barSnapshot.layer.opacity = 0.0

        let barSnapshotGroup = CAAnimationGroup()
        barSnapshotGroup.animations = [barSnapshotAnimation, barSnapshotAlphaAnimation]
        barSnapshotGroup.isRemovedOnCompletion = true
        barSnapshot.layer.add(barSnapshotGroup, forKey: nil)

        let showSubviewAnimation = CABasicAnimation(keyPath: "opacity")
        showSubviewAnimation.fromValue = 0.0
        showSubviewAnimation.toValue = 1.0
        showSubviewAnimation.duration = duration * 0.5
        showSubviewAnimation.beginTime = CACurrentMediaTime() + duration * 0.5
        showSubviewAnimation.isRemovedOnCompletion = true

        let slideUpAnimation = CABasicAnimation(keyPath: "position.y")
        slideUpAnimation.fromValue = UIScreen.main.bounds.height
        slideUpAnimation.duration = duration * 0.5
        slideUpAnimation.isRemovedOnCompletion = true
        presented.boxView.boxView.layer.add(slideUpAnimation, forKey: nil)

        presented.boxView.boxView.subviews.forEach {
            $0.layer.add(showSubviewAnimation, forKey: nil)
        }

        CATransaction.commit()
    }

}
