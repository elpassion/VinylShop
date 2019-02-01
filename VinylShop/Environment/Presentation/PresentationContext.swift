import UIKit

struct PresentationContext {
    let factory: () -> UIViewController
    let animated: Bool
    let presentationStyle: UIModalPresentationStyle
    let transitionStyle: UIModalTransitionStyle
    let transitioningDelegate: UIViewControllerTransitioningDelegate

    init(factory: @escaping () -> UIViewController,
         animated: Bool,
         presentationStyle: UIModalPresentationStyle,
         transitionStyle: UIModalTransitionStyle,
         presentAnimator: UIViewControllerAnimatedTransitioning?,
         dismissAnimator: UIViewControllerAnimatedTransitioning?) {
        self.factory = factory
        self.animated = animated
        self.presentationStyle = presentationStyle
        self.transitionStyle = transitionStyle
        self.transitioningDelegate = PresentationTransitioningDelegate(
            presentAnimator: presentAnimator,
            dismissAnimator: dismissAnimator
        )
    }
}
