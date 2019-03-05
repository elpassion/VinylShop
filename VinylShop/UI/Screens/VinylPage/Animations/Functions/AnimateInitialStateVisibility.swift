import UIKit

func animateInitialStateVisibility(_ context: BuyAnimationContext) {
    let hiddenViews: [UIView] = [
        context.barView.albumCoverView,
        context.barView.checkoutBoxBackView,
        context.barView.checkoutBoxView,
        context.detailsView.headerView.coverImageView
    ]
    hiddenViews.forEach { $0.alpha = 0.0 }

    let shownViews: [UIView] = [context.boxBackView, context.boxFrontView, context.barView]
    shownViews.forEach { $0.alpha = 1.0 }
}
