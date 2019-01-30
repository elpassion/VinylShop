import UIKit

class ShoppingBoxController: UIViewController {

    init(presenter: ShoppingBoxPresenter = ShoppingBoxPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    var boxView: ShoppingBoxView! {
        return view as? ShoppingBoxView
    }

    override func loadView() {
        view = ShoppingBoxView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let albums = [
            Album(title: "We the generation", band: "Rudimental"),
            Album(title: "Appetite for Destruction", band: "Guns N' Roses")
        ]

        presenter.present(albums: albums, in: boxView)
    }

    // MARK: - Private

    private let presenter: ShoppingBoxPresenter

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { return nil }

}
