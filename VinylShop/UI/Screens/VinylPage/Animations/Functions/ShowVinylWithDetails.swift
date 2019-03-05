import UIKit

func showVinylWithDetails(_ context: BuyAnimationContext) {
    context.detailsView.headerView.coverImageView.alpha = 1.0
    context.detailsView.headerView.vinylView.alpha = 1.0
    [context.barView.titleLabel, context.barView.albumCountLabel, context.barView.totalLabel].forEach { $0.alpha = 1.0 }
}
