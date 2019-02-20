@testable import VinylShop
import UIKit

class BuyAnimatorSpy: BuyAnimating {

    private(set) var invokedAnimateBuy: BuyAnimatorInvocation?

    // MARK: - BuyAnimating

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

struct BuyAnimatorInvocation {
    let view: UIView
    let detailsView: VinylDetailsView
    let barView: ShoppingBarView
    let completion: () -> Void
    let count: Int
}
