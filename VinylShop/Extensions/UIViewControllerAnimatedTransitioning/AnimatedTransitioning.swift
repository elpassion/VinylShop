import UIKit

protocol AnimatedTransitioning: UIViewControllerAnimatedTransitioning {
    var allAnimators: [UIViewPropertyAnimator] { get }
}

extension AnimatedTransitioning {

    var duration: TimeInterval {
        return allAnimators.map { $0.duration }.max() ?? transitionDuration(using: nil)
    }

}
