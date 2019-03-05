import UIKit

func presentShoppingBar(_ initialFrames: BuyInitialFrames, _ isInitialState: Bool) -> (BuyAnimationContext) -> Void {
    return { context in
        if isInitialState {
            moveUpBarView(context, initialFrames: initialFrames)
        }

        hideBarViewDetails(context)
        scaleUpFrontBoxView(context)
        scaleUpBackBoxView(context)
    }
}

private func moveUpBarView(_ context: BuyAnimationContext, initialFrames: BuyInitialFrames) {
    [context.barView, context.boxFrontView, context.boxBackView].forEach { view in
        view.frame = view.frame.offsetBy(dx: 0, dy: -initialFrames.shoppingBar.height)
    }
}

private func scaleUpFrontBoxView(_ context: BuyAnimationContext, _ multiplier: CGFloat = 3.0) {
    context.boxFrontView.frame = CGRect(
        x: context.barView.frameControl.frame.midX - context.boxFrontView.frame.width * 0.5 * multiplier,
        y: context.boxFrontView.frame.midY - context.boxFrontView.frame.height * 0.5 * multiplier,
        width: context.boxFrontView.frame.width * multiplier,
        height: context.boxFrontView.frame.height * multiplier
    )
}

private func scaleUpBackBoxView(_ context: BuyAnimationContext, _ multiplier: CGFloat = 3.0) {
    context.boxBackView.frame = CGRect(
        x: context.barView.frame.midX - context.boxBackView.frame.width * 0.5 * multiplier,
        y: context.boxFrontView.frame.maxY - context.boxBackView.frame.height * multiplier,
        width: context.boxBackView.frame.width * multiplier,
        height: context.boxBackView.frame.height * multiplier
    )
}
