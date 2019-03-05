import UIKit

func hideVinylView(_ context: BuyAnimationContext) {
    let vinylView = context.detailsView.headerView.vinylView

    vinylView.alpha = 0.0
    vinylView.transform = vinylView.transform.translatedBy(
        x: context.detailsView.headerView.coverImageView.frame.midX - vinylView.frame.midX,
        y: 0
    )
}
