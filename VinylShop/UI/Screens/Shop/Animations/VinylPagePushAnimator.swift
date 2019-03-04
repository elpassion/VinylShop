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
        guard let shopController = transitionContext.viewController(forKey: .from) as? ShopController,
              let pageController = transitionContext.viewController(forKey: .to) as? VinylPageController,
              let newController = shopController.newController as? VinylCollectionController,
              let recommendedController = shopController.recommendedController as? VinylCollectionController else {
            transitionContext.complete()
            return
        }

        let vinylCell = [newController, recommendedController].compactMap { $0.visibleCell(forVinylID: vinylID) }.first

        guard let cell = vinylCell,
              let cellCoverSnapshot = cell.coverImageView.snapshotView(afterScreenUpdates: true) else {
            return
        }

        cellCoverSnapshot.frame = shopController.view.convert(cellCoverSnapshot.frame, from: cell.contentView)

        let containerView = transitionContext.containerView
        containerView.addSubview(pageController.view)
        containerView.addSubview(shopController.view)
        containerView.addSubview(cellCoverSnapshot)

        pageController.view.frame = shopController.view.frame
        pageController.view.setNeedsLayout()
        pageController.view.layoutIfNeeded()

        let headerView = pageController.detailsController.detailsView.headerView
        headerView.coverImageView.alpha = 0.0
        headerView.vinylView.alpha = 0.0

        let shopAnimator = makeShopAnimator(view: shopController.view)

        let headerAnimator = makeHeaderAnimator(view: headerView)

        let vinylAnimator = makeVinylAnimator(view: headerView.vinylView, fromCenter: headerView.coverImageView.center)
        vinylAnimator.addCompletion { _ in
            headerView.coverImageView.alpha = 1.0
            cellCoverSnapshot.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        let arrowAnimator = makeArrowAnimator(view: headerView.backButton)

        let coverFrame = pageController.view.convert(headerView.coverImageView.frame, from: headerView)
        let cellAnimator = makeCellAnimator(view: cellCoverSnapshot, to: coverFrame)

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
        let velocity = CGVector(dx: 0, dy: 20)
        let timingParameters = UISpringTimingParameters(mass: 1, stiffness: 100, damping: 20, initialVelocity: velocity)
        let frame = view.frame
        view.frame = CGRect(origin: frame.origin, size: CGSize(width: frame.width, height: frame.height + 30))
        view.alpha = 0.0

        let animator = UIViewPropertyAnimator(duration: 0.3, timingParameters: timingParameters)
        animator.addAnimations {
            view.alpha = 1.0
            view.frame = frame
        }

        return animator
    }

    private func makeCellAnimator(view: UIView, to frame: CGRect) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
            view.frame = frame
        }
    }

    private func makeVinylAnimator(view: UIView, fromCenter: CGPoint) -> UIViewPropertyAnimator {
        let center = view.center
        view.alpha = 0.0
        view.center.x = fromCenter.x
        let duration = self.duration

        return UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            UIView.keyframeAnimation(duration: duration) {
                UIView.addKeyframe(withRelativeStartTime: 0.37 / duration, relativeDuration: 0.46 / duration) {
                    view.center.x = center.x
                }

                UIView.addKeyframe(withRelativeStartTime: 0.4 / duration, relativeDuration: 0.08 / duration) {
                    view.alpha = 1.0
                }
            }
        }
    }

    private func makeArrowAnimator(view: UIView) -> UIViewPropertyAnimator {
        let duration = self.duration
        view.center.x += 20
        view.alpha = 0.0
        return UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            UIView.keyframeAnimation(duration: duration) {
                UIView.addKeyframe(withRelativeStartTime: 0.3 / duration, relativeDuration: 0.3 / duration) {
                    view.center.x -= 20
                    view.alpha = 1.0
                }
            }
        }
    }

}
