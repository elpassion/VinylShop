import UIKit

protocol BuyAnimating {
    var duration: Double { get }
    var allAnimators: [UIViewPropertyAnimator] { get }

    func animateBuy(view: UIView,
                    detailsView: VinylDetailsView,
                    barView: ShoppingBarView,
                    completion: @escaping () -> Void)
}
