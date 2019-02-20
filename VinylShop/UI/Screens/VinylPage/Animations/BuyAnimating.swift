import UIKit

protocol BuyAnimating {
    func animateBuy(view: UIView,
                    detailsView: VinylDetailsView,
                    barView: ShoppingBarView,
                    completion: @escaping () -> Void)
}
