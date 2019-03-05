@testable import VinylShop
import UIKit

class BuyAnimatorSpy: BuyAnimating {

    var stubbedDuration: Double = 0.0
    var stubbedAnimators: [UIViewPropertyAnimator] = []
    private(set) var invokedAnimateBuy: BuyAnimatorInvocation?

    struct BuyAnimatorInvocation {
        let view: UIView
        let detailsView: VinylDetailsView
        let barView: ShoppingBarView
        let completion: () -> Void
        let count: Int
    }

    // MARK: - BuyAnimating

    var duration: Double {
        return stubbedDuration
    }

    var allAnimators: [UIViewPropertyAnimator] {
        return stubbedAnimators
    }

    func animateBuy(view: UIView,
                    detailsView: VinylDetailsView,
                    barView: ShoppingBarView,
                    completion: @escaping () -> Void) {
        invokedAnimateBuy = BuyAnimatorInvocation(
            view: view,
            detailsView: detailsView,
            barView: barView,
            completion: completion,
            count: invokedAnimateBuy.map { $0.count + 1 } ?? 1
        )
    }

}
