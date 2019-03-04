import Anchorage
import UIKit

class VinylPagePopAnimator: NSObject, AnimatedTransitioning {

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
        guard let context = VinylPagePopAnimatorContext(vinylID: vinylID, transitionContext: transitionContext) else {
            transitionContext.complete()
            return
        }

        let headerView = context.pageController.detailsController.detailsView.headerView

        context.coverSnapshotView.frame = context.pageController.view.convert(
            headerView.coverImageView.frame,
            from: headerView
        )

        let containerView = transitionContext.containerView
        containerView.addSubview(context.shopController.view)
        containerView.addSubview(context.pageController.view)
        containerView.addSubview(context.coverSnapshotView)

        headerView.coverImageView.alpha = 0.0

        let vinylPageAnimator = makeVinylPageAnimator(view: context.pageController.view)
        let headerAnimator = makeHeaderAnimator(view: headerView)
        let vinylAnimator = makeVinylAnimator(view: headerView.vinylView, toCenter: headerView.coverImageView.center)
        let arrowAnimator = makeArrowAnimator(view: headerView.backButton)

        let coverFrame = context.shopController.view.convert(
            context.vinylCell.coverImageView.frame,
            from: context.vinylCell.contentView
        )

        let coverAnimator = makeCoverAnimator(view: context.coverSnapshotView, to: coverFrame)
        coverAnimator.addCompletion { _ in
            headerView.coverImageView.alpha = 1.0
            context.coverSnapshotView.removeFromSuperview()
            transitionContext.complete()
        }

        allAnimators = [vinylPageAnimator, headerAnimator, vinylAnimator, arrowAnimator, coverAnimator]
        allAnimators.forEach { $0.startAnimation() }
    }

    // MARK: - Private

    private func makeVinylPageAnimator(view: UIView) -> UIViewPropertyAnimator {
        let duration = self.duration

        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            UIView.delayedKeyframeAnimation(relativeDuration: 0.1 / duration, totalDuration: duration, delay: 0.73) {
                view.alpha = 0.0
            }
        }

        animator.addCompletion { _ in
            view.removeFromSuperview()
            view.alpha = 1.0
        }

        return animator
    }

    private func makeHeaderAnimator(view: VinylDetailsHeaderView) -> UIViewPropertyAnimator {
        let duration = self.duration
        let frame = view.frame

        let animator = UIViewPropertyAnimator(
            duration: duration,
            timingParameters: UISpringTimingParameters.headerTiming
        )

        animator.addAnimations {
            UIView.delayedKeyframeAnimation(relativeDuration: 0.3, totalDuration: duration, delay: 0.53) {
                view.alpha = 0.0
                view.frame = CGRect(origin: frame.origin, size: CGSize(width: frame.width, height: 0))
            }
        }

        return animator
    }

    private func makeCoverAnimator(view: UIView, to frame: CGRect) -> UIViewPropertyAnimator {
        let duration = self.duration

        return UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            UIView.delayedKeyframeAnimation(relativeDuration: 0.3 / duration, totalDuration: duration, delay: 0.53) {
                view.frame = frame
            }
        }
    }

    private func makeVinylAnimator(view: UIView, toCenter: CGPoint) -> UIViewPropertyAnimator {
        let duration = self.duration

        return UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            UIView.keyframeAnimation(duration: duration) {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.46 / duration) {
                    view.center.x = toCenter.x
                }

                UIView.addKeyframe(withRelativeStartTime: 0.43 / duration, relativeDuration: 0.08 / duration) {
                    view.alpha = 0.0
                }
            }
        }
    }

    private func makeArrowAnimator(view: UIView) -> UIViewPropertyAnimator {
        let duration = self.duration

        return UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            UIView.delayedKeyframeAnimation(relativeDuration: 0.3 / duration, totalDuration: duration, delay: 0.23) {
                view.center.x += 20
                view.alpha = 0.0
            }
        }
    }

}
