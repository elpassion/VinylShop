import UIKit

func cleanUpBuyAnimation(_ context: BuyAnimationContext) {
    [context.boxFrontView, context.coverView, context.boxBackView].forEach { $0.removeFromSuperview() }
}
