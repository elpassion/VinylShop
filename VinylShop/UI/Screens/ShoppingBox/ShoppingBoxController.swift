import UIKit

class ShoppingBoxController: UIViewController {

    var boxView: ShoppingBoxView! {
        return view as? ShoppingBoxView
    }

    override func loadView() {
        view = ShoppingBoxView()
    }

}
