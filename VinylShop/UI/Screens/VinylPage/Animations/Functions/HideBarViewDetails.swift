import UIKit

func hideBarViewDetails(_ context: BuyAnimationContext) {
    let viewsToHide: [UIView] = [
        context.barView.titleLabel,
        context.barView.albumCoverView,
        context.barView.albumCountLabel,
        context.barView.totalLabel
    ]

    viewsToHide.forEach { $0.alpha = 0.0 }
}
