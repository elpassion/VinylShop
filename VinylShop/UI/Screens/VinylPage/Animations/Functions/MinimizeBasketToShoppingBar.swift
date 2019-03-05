import UIKit

func minimizeBasketToShoppingBar(_ context: BuyAnimationContext) {
    context.boxFrontView.frame = context.parentView.converted(context.barView.checkoutBoxView)
    context.boxBackView.frame = context.parentView.converted(context.barView.checkoutBoxBackView)
    context.coverView.frame = context.parentView.converted(context.barView.albumCoverView)
}
