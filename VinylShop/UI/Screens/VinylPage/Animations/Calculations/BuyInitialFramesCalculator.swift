import UIKit

class BuyInitialFramesCalculator {

    func calculateInitialFrames(isInitialState: Bool,
                                barView: ShoppingBarView,
                                detailsView: VinylDetailsView,
                                view: UIView) -> BuyInitialFrames {
        var boxFront = view.converted(barView.checkoutBoxView)
        var boxBack = view.converted(barView.checkoutBoxBackView)
        var shoppingBar = barView.frameControl.frame
        let coverView = view.converted(detailsView.headerView.coverImageView)

        if isInitialState {
            boxFront.origin = CGPoint(
                x: shoppingBar.midX - boxFront.width * 0.5,
                y: boxFront.minY + shoppingBar.height
            )

            boxBack.origin = CGPoint(
                x: shoppingBar.midX - boxBack.width * 0.5,
                y: boxBack.minY + shoppingBar.height
            )

            shoppingBar.origin = CGPoint(x: shoppingBar.minX, y: shoppingBar.maxY)
        }

        return BuyInitialFrames(boxFront: boxFront, boxBack: boxBack, shoppingBar: shoppingBar, coverView: coverView)
    }

}
