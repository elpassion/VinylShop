import Anchorage
import UIKit

extension UIViewController {

    // MARK: - Embedding

    public func embed(childViewController: UIViewController, inside targetView: UIView? = nil) {
        let containerView: UIView = targetView ?? view

        embed(childViewController: childViewController) { view in
            containerView.addSubview(view)
            view.edgeAnchors == containerView.edgeAnchors
        }
    }

    public func embed(childViewController: UIViewController, using embeddingMethod: (UIView) -> Void) {
        addChild(childViewController)
        embeddingMethod(childViewController.view)
        childViewController.didMove(toParent: self)
    }

}
