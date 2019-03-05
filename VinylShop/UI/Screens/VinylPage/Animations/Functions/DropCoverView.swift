import UIKit

func dropCoverView(_ multiplier: CGFloat = 3.0) -> (BuyAnimationContext) -> Void {
    return { context in
        let width = context.barView.albumCoverView.frame.width * multiplier
        let height = context.barView.albumCoverView.frame.size.height * multiplier
        let barViewFrame = context.parentView.converted(context.barView.frameControl)

        context.coverView.transform = .identity
        context.coverView.frame = CGRect(
            x: barViewFrame.midX - width * 0.5,
            y: barViewFrame.midY - context.boxFrontView.frame.height * 0.5 * multiplier + 21,
            width: width,
            height: height
        )
    }
}
