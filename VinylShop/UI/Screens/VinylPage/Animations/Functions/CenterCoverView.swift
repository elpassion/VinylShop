import UIKit

func centerCoverView(_ context: BuyAnimationContext) {
    context.coverView.transform = context.coverView.transform.translatedBy(
        x: context.detailsView.headerView.frame.midX - context.coverView.frame.midX,
        y: 0
    )
}
