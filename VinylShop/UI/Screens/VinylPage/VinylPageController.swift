import UIKit

class VinylPageController: UIViewController {

    init(barControllerFactory: @escaping () -> ShoppingBarControlling = ShoppingBarController.init,
         environment: Environment = .shared) {
        self.barControllerFactory = barControllerFactory
        self.environment = environment

        super.init(nibName: nil, bundle: nil)
    }

    lazy var barController: ShoppingBarControlling = barControllerFactory()

    var pageView: VinylPageView! {
        return view as? VinylPageView
    }

    override func loadView() {
        view = VinylPageView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        embedBarController()
        setUpBarControlTap()
    }

    // MARK: - Private

    private let barControllerFactory: () -> ShoppingBarControlling
    private let environment: Environment

    private func embedBarController() {
        embed(childViewController: barController, inside: pageView.barContainerView)
    }

    private func setUpBarControlTap() {
        barController.barControl.addTarget(self, action: #selector(onBarControlTap), for: .touchUpInside)
    }

    @objc private func onBarControlTap(_: UIControl) {
        environment.presentation.present(context: .shoppingBox)
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
