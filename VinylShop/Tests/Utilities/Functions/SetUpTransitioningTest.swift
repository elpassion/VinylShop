@testable import VinylShop
import SnapshotTesting
import SpecTools
import UIKit

enum TransitioningTestDirection {
    case forwards
    case backwards
}

func setUpTransitioningTest(from: UIViewController,
                            to: UIViewController,
                            using context: UIViewControllerContextTransitioningSpy,
                            in window: UIWindow,
                            direction: TransitioningTestDirection = .forwards) {
    let bounds = CGRect(origin: .zero, size: ViewImageConfig.iPhoneX.size ?? .zero)
    from.spec.prepare.set(viewSize: bounds.size)

    if direction == .backwards {
        to.spec.prepare.set(viewSize: bounds.size)
    }

    context.containerView.frame = bounds
    context.stubbedViewControllerFrom = from
    context.stubbedViewControllerTo = to

    window.frame = bounds
    window.isHidden = false
    window.rootViewController = from
    window.addSubview(context.containerView)
    window.setNeedsLayout()
    window.layoutIfNeeded()
}
