import UIKit

protocol AnimatedTransitioning: UIViewControllerAnimatedTransitioning {
    var allAnimators: [UIViewPropertyAnimator] { get }
}

extension AnimatedTransitioning {

    var duration: TimeInterval {
        return transitionDuration(using: nil)
    }

}
