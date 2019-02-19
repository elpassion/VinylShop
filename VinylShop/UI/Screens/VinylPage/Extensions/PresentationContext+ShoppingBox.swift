import UIKit

extension PresentationContext {

    static var shoppingBox: PresentationContext {
        return PresentationContext(
            id: .shoppingBox,
            factory: { ShoppingBoxController() },
            animated: true,
            presentationStyle: .overCurrentContext,
            transitionStyle: .crossDissolve,
            presentAnimator: ShoppingBoxPresentationAnimator(),
            dismissAnimator: ShoppingBoxDismissAnimator()
        )
    }

}
