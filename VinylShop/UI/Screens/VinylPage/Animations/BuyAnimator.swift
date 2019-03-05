import UIKit

class BuyAnimator: BuyAnimating {

    // MARK: - BuyAnimating

    var duration: Double = 1.1
    var allAnimators: [UIViewPropertyAnimator] = []

    func animateBuy(view: UIView,
                    detailsView: VinylDetailsView,
                    barView: ShoppingBarView,
                    completion: @escaping () -> Void) {
        let isInitialState = barView.alpha == 0.0

        let initialFrames = initialFramesCalculator.calculateInitialFrames(
            isInitialState: isInitialState,
            barView: barView,
            detailsView: detailsView,
            view: view
        )

        let context = BuyAnimationContext(
            parentView: view,
            detailsView: detailsView,
            barView: barView,
            initialFrames: initialFrames
        )

        [context.boxBackView, context.coverView, context.boxFrontView].forEach(view.addSubview(_:))

        let keyframes: [Keyframe<BuyAnimationContext>] = [
            Keyframe(play: animateInitialStatePositions(initialFrames, isInitialState), from: 0.0, by: 0.025),
            Keyframe(play: animateInitialStateVisibility, from: 0.025, by: 0.025),
            Keyframe(play: presentShoppingBar(initialFrames, isInitialState), from: 0.05, by: 0.3),
            Keyframe(play: hideVinylView, from: 0.05, by: 0.1),
            Keyframe(play: centerCoverView, from: 0.05, by: 0.3),
            Keyframe(play: dropCoverView(), from: 0.35, by: 0.3),
            Keyframe(play: minimizeBasketToShoppingBar, from: 0.65, by: 0.3),
            Keyframe(play: resetVinylPosition, from: 0.8, by: 0.001),
            Keyframe(play: showOriginalBasket, from: 0.95, by: 0.001),
            Keyframe(play: showVinylWithDetails, from: 0.8, by: 0.3)
        ]

        let animator = UIViewPropertyAnimator(duration: duration, curve: .linear, keyframes: keyframes, with: context)
        animator.addCompletion { state in
            if state == .end {
                cleanUpBuyAnimation(context)
            }

            completion()
        }

        allAnimators = [animator]
        allAnimators.forEach { $0.startAnimation() }
    }

    // MARK: - Private

    private let initialFramesCalculator: BuyInitialFramesCalculator = BuyInitialFramesCalculator()

}
