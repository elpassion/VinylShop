import UIKit

extension PresentationContext {

    static var shoppingBox: PresentationContext {
        return PresentationContext(
            id: .shoppingBox,
            factory: { ShoppingBoxController() },
            animated: true,
            presentationStyle: .custom,
            transitionStyle: .crossDissolve,
            presentAnimator: ShoppingBoxPresentationAnimator(),
            dismissAnimator: ShoppingBoxDismissAnimator()
        )
    }

}
