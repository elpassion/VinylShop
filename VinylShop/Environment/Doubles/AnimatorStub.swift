@testable import VinylShop
import UIKit

class AnimatorStub: NSObject, AnimatedTransitioning {

    var stubbedDuration: Double = 0.0
    var stubbedAnimators: [UIViewPropertyAnimator] = []

    // MARK: - AnimatedTransitioning

    var allAnimators: [UIViewPropertyAnimator] {
        return stubbedAnimators
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return stubbedDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {}

}
