import UIKit

class PresentationTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    init(presentAnimator: UIViewControllerAnimatedTransitioning?,
         dismissAnimator: UIViewControllerAnimatedTransitioning?) {
        self.presentAnimator = presentAnimator
        self.dismissAnimator = dismissAnimator
    }
    
    // MARK: - UIViewControllerTransitioningDelegate

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimator
    }

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimator
    }

    // MARK: - Private

    private let presentAnimator: UIViewControllerAnimatedTransitioning?
    private let dismissAnimator: UIViewControllerAnimatedTransitioning?

}
