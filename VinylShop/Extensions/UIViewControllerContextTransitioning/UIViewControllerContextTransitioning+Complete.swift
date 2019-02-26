import UIKit

extension UIViewControllerContextTransitioning {

    func complete() {
        completeTransition(!transitionWasCancelled)
    }

}
