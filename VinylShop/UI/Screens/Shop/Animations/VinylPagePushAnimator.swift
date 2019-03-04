import Anchorage
import UIKit

class VinylPagePushAnimator: NSObject, AnimatedTransitioning {

    let vinylID: Int

    init(vinylID: Int) {
        self.vinylID = vinylID
    }

    // MARK: - AnimatedTransitioning

    var allAnimators: [UIViewPropertyAnimator] = []

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.83
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let context = VinylPagePushAnimatorContext(vinylID: vinylID, transitionContext: transitionContext) else {
            transitionContext.complete()
            return
        }

        context.coverSnapshotView.frame = context.shopController.view.convert(
            context.coverSnapshotView.frame,
            from: context.vinylCell.contentView
        )

        let containerView = transitionContext.containerView
        containerView.addSubview(context.pageController.view)
        containerView.addSubview(context.shopController.view)
        containerView.addSubview(context.coverSnapshotView)

        context.pageController.view.frame = context.shopController.view.frame
        context.pageController.view.setNeedsLayout()
        context.pageController.view.layoutIfNeeded()

        let headerView = context.pageController.detailsController.detailsView.headerView
        headerView.coverImageView.alpha = 0.0
        headerView.vinylView.alpha = 0.0

        let shopAnimator = makeShopAnimator(view: context.shopController.view)

        let headerAnimator = makeHeaderAnimator(view: headerView)

        let vinylAnimator = makeVinylAnimator(view: headerView.vinylView, fromCenter: headerView.coverImageView.center)
        vinylAnimator.addCompletion { _ in
            headerView.coverImageView.alpha = 1.0
            context.coverSnapshotView.removeFromSuperview()
            transitionContext.complete()
        }

        let arrowAnimator = makeArrowAnimator(view: headerView.backButton)

        let coverFrame = context.pageController.view.convert(headerView.coverImageView.frame, from: headerView)
        let cellAnimator = makeCellAnimator(view: context.coverSnapshotView, to: coverFrame)

        allAnimators = [shopAnimator, headerAnimator, vinylAnimator, arrowAnimator, cellAnimator]
        allAnimators.forEach { $0.startAnimation() }
    }

    // MARK: - Private

    private func makeShopAnimator(view: UIView) -> UIViewPropertyAnimator {
        let animator = UIViewPropertyAnimator(duration: 0.1, curve: .easeInOut) {
            view.alpha = 0.0
        }

        animator.addCompletion { _ in
            view.removeFromSuperview()
            view.alpha = 1.0
        }

        return animator
    }

    private func makeHeaderAnimator(view: VinylDetailsHeaderView) -> UIViewPropertyAnimator {
        view.frame = view.frame.enlarged(height: 30)
        view.alpha = 0.0

        let animator = UIViewPropertyAnimator(duration: 0.3, timingParameters: UISpringTimingParameters.headerTiming)
        animator.addAnimations {
            view.alpha = 1.0
            view.frame = view.frame.enlarged(height: -30)
        }

        return animator
    }

    private func makeCellAnimator(view: UIView, to frame: CGRect) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
            view.frame = frame
        }
    }

    private func makeVinylAnimator(view: UIView, fromCenter: CGPoint) -> UIViewPropertyAnimator {
        let duration = self.duration
        view.alpha = 0.0
        view.transform = CGAffineTransform(translationX: fromCenter.x - view.center.x, y: 0)

        return UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            UIView.keyframeAnimation(duration: duration) {
                UIView.addKeyframe(withRelativeStartTime: 0.37 / duration, relativeDuration: 0.46 / duration) {
                    view.transform = CGAffineTransform.identity
                }

                UIView.addKeyframe(withRelativeStartTime: 0.4 / duration, relativeDuration: 0.08 / duration) {
                    view.alpha = 1.0
                }
            }
        }
    }

    private func makeArrowAnimator(view: UIView) -> UIViewPropertyAnimator {
        let duration = self.duration
        view.transform = CGAffineTransform(translationX: 20, y: 0)
        view.alpha = 0.0

        return UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            UIView.delayedKeyframeAnimation(relativeDuration: 0.3 / duration, totalDuration: duration, delay: 0.3) {
                view.transform = CGAffineTransform.identity
                view.alpha = 1.0
            }
        }
    }

}
