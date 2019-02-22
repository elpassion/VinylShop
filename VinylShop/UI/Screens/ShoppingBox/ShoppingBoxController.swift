import UIKit

class ShoppingBoxController: UIViewController {

    init(presenter: ShoppingBoxPresenter = ShoppingBoxPresenter(), environment: Environment = .shared) {
        self.presenter = presenter
        self.environment = environment
        super.init(nibName: nil, bundle: nil)
    }

    var boxView: ShoppingBoxView {
        return cast(view: view)
    }

    override func loadView() {
        view = ShoppingBoxView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presentAlbums()
        setUpDismissOnBackgroundTap()
    }

    // MARK: - Private

    private let presenter: ShoppingBoxPresenter
    private let environment: Environment

    private func presentAlbums() {
        let albums = [
            Album(title: "We the generation", band: "Rudimental"),
            Album(title: "Appetite for Destruction", band: "Guns N' Roses")
        ]

        presenter.present(albums: albums, in: boxView)
    }

    private func setUpDismissOnBackgroundTap() {
        boxView.tapGestureRecognizer.addTarget(self, action: #selector(onDismissTriggered))
        boxView.swipeGestureRecognizer.addTarget(self, action: #selector(onDismissTriggered))
    }

    @objc
    private func onDismissTriggered() {
        environment.presentation.dismiss(self, animated: true)
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { return nil }

}
