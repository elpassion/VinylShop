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
    }

}
