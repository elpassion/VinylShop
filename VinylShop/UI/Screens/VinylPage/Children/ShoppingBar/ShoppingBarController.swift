import UIKit

class ShoppingBarController: UIViewController, ShoppingBarControllerProtocol {

    var barView: ShoppingBarView! {
        return view as? ShoppingBarView
    }

    override func loadView() {
        view = ShoppingBarView()
    }

    // MARK: - ShoppingBarControllerProtocol

    var barControl: UIControl {
        return barView.frameControl
    }

}
