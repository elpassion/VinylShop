import UIKit

class ShoppingBarController: UIViewController, ShoppingBarControllerProtocol {

    var barView: ShoppingBarView {
        return forceCast(view)
    }

    override func loadView() {
        view = ShoppingBarView()
    }

    // MARK: - ShoppingBarControllerProtocol

    var barControl: UIControl {
        return barView.frameControl
    }

}
