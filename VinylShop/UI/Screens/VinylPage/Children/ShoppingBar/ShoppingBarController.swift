import UIKit

class ShoppingBarController: UIViewController, ShoppingBarControllerProtocol {

    var barView: ShoppingBarView {
        return cast(view: view)
    }

    override func loadView() {
        view = ShoppingBarView()
    }

    // MARK: - ShoppingBarControllerProtocol

    var barControl: UIControl {
        return barView.frameControl
    }

}
