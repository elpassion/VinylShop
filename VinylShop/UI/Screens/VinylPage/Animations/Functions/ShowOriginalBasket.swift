import UIKit

func showOriginalBasket(_ context: BuyAnimationContext) {
    context.barView.albumCoverView.alpha = 1.0
    context.coverView.alpha = 0.0
    context.barView.checkoutBoxBackView.alpha = 1.0
    context.boxBackView.alpha = 0.0
    context.barView.checkoutBoxView.alpha = 1.0
    context.boxFrontView.alpha = 0.0
}
