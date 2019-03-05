import UIKit

func animateInitialStatePositions(_ initialFrames: BuyInitialFrames,
                                  _ isInitialState: Bool) -> (BuyAnimationContext) -> Void {
    return { context in
        if isInitialState {
            hideBarViewDetails(context)
            context.barView.frame = initialFrames.shoppingBar
        }
    }
}
