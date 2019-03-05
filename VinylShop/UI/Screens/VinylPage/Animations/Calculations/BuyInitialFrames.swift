import UIKit

struct BuyInitialFrames {
    let boxFront: CGRect
    let boxBack: CGRect
    let shoppingBar: CGRect
    let coverView: CGRect

    init(boxFront: CGRect = .zero, boxBack: CGRect = .zero, shoppingBar: CGRect = .zero, coverView: CGRect = .zero) {
        self.boxFront = boxFront
        self.boxBack = boxBack
        self.shoppingBar = shoppingBar
        self.coverView = coverView
    }
}
