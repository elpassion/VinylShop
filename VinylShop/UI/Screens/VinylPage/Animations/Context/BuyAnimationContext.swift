import UIKit

struct BuyAnimationContext {
    let parentView: UIView
    let detailsView: VinylDetailsView
    let barView: ShoppingBarView
    let boxFrontView: UIView
    let boxBackView: UIView
    let coverView: UIView

    init(parentView: UIView, detailsView: VinylDetailsView, barView: ShoppingBarView, initialFrames: BuyInitialFrames) {
        self.parentView = parentView
        self.detailsView = detailsView
        self.barView = barView
        self.boxFrontView = copy(barView.checkoutBoxView, withFrame: initialFrames.boxFront)
        self.boxBackView = copy(barView.checkoutBoxBackView, withFrame: initialFrames.boxBack)
        self.coverView = copy(detailsView.headerView.coverImageView, withFrame: initialFrames.coverView)
    }
}

private func copy(_ referenceImageView: UIImageView, withFrame frame: CGRect) -> UIImageView {
    let imageView = UIImageView(frame: frame)
    imageView.contentMode = referenceImageView.contentMode
    imageView.image = referenceImageView.image

    return imageView
}
