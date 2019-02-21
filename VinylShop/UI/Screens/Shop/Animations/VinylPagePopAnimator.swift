import Anchorage
import UIKit

class VinylPagePopAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    let vinylID: Int

    init(vinylID: Int) {
        self.vinylID = vinylID
    }

    // MARK: - UIViewControllerAnimatedTransitioning

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.83
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let shopController = transitionContext.viewController(forKey: .to) as? ShopController,
              let pageController = transitionContext.viewController(forKey: .from) as? VinylPageController,
              let newController = shopController.newController as? VinylCollectionController,
              let recommendedController = shopController.recommendedController as? VinylCollectionController else {
            return
        }

        let vinylCell = [newController, recommendedController].compactMap { $0.visibleCell(forVinylID: vinylID) }.first
        let headerView = pageController.detailsController.detailsView.headerView

        guard let cell = vinylCell,
              let coverSnapshot = headerView.coverImageView.snapshotView(afterScreenUpdates: true) else {
            return
        }

        coverSnapshot.frame = pageController.view.convert(headerView.coverImageView.frame, from: headerView)

        let containerView = transitionContext.containerView
        containerView.addSubview(shopController.view)
        containerView.addSubview(pageController.view)
        containerView.addSubview(coverSnapshot)

        let vinylPageAnimator = makeVinylPageAnimator(view: pageController.view)
        vinylPageAnimator.startAnimation()

        let headerAnimator = makeHeaderAnimator(view: headerView)
        headerAnimator.startAnimation()

        let vinylAnimator = makeVinylAnimator(view: headerView.vinylView, toCenter: headerView.coverImageView.center)
        vinylAnimator.startAnimation()

        let arrowAnimator = makeArrowAnimator(view: headerView.backButton)
        arrowAnimator.startAnimation()

        let coverFrame = shopController.view.convert(cell.coverImageView.frame, from: cell.contentView)
        let coverAnimator = makeCoverAnimator(view: coverSnapshot, to: coverFrame)
        coverAnimator.addCompletion { _ in
            coverSnapshot.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        coverAnimator.startAnimation()

        headerView.coverImageView.frame = .zero
    }

    // MARK: - Private

    private var duration: Double {
        return transitionDuration(using: nil)
    }

    private func makeVinylPageAnimator(view: UIView) -> UIViewPropertyAnimator {
        let duration = self.duration

        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            UIView.animateKeyframes(withDuration: duration, delay: 0, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.73 / duration, relativeDuration: 0.1 / duration) {
                    view.alpha = 0.0
                }
            })
        }

        animator.addCompletion { _ in
            view.removeFromSuperview()
            view.alpha = 1.0
        }

        return animator
    }

    private func makeHeaderAnimator(view: VinylDetailsHeaderView) -> UIViewPropertyAnimator {
        let duration = self.duration
        let velocity = CGVector(dx: 0, dy: 20)
        let timingParameters = UISpringTimingParameters(mass: 1, stiffness: 100, damping: 20, initialVelocity: velocity)
        let frame = view.frame

        let animator = UIViewPropertyAnimator(duration: duration, timingParameters: timingParameters)
        animator.addAnimations {
            UIView.animateKeyframes(withDuration: duration, delay: 0, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.53 / duration, relativeDuration: 0.3) {
                    view.alpha = 0.0
                    view.frame = CGRect(origin: frame.origin, size: CGSize(width: frame.width, height: 0))
                }
            })
        }

        return animator
    }

    private func makeCoverAnimator(view: UIView, to frame: CGRect) -> UIViewPropertyAnimator {
        let duration = self.duration

        return UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            UIView.animateKeyframes(withDuration: duration, delay: 0, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.53 / duration, relativeDuration: 0.3 / duration) {
                    view.frame = frame
                }
            })
        }
    }

    private func makeVinylAnimator(view: UIView, toCenter: CGPoint) -> UIViewPropertyAnimator {
        let duration = self.duration

        return UIViewPropertyAnimator(duration: 0.46, curve: .easeInOut) {
            UIView.animateKeyframes(withDuration: duration, delay: 0, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.46 / duration) {
                    view.center.x = toCenter.x
                }

                UIView.addKeyframe(withRelativeStartTime: 0.43 / duration, relativeDuration: 0.08 / duration) {
                    view.alpha = 0.0
                }
            })
        }
    }

    private func makeArrowAnimator(view: UIView) -> UIViewPropertyAnimator {
        let duration = self.duration

        return UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            UIView.animateKeyframes(withDuration: duration, delay: 0, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.23 / duration, relativeDuration: 0.3 / duration) {
                    view.center.x += 20
                    view.alpha = 0.0
                }
            })
        }
    }

}
