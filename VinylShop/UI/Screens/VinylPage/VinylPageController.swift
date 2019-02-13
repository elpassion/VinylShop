import UIKit

class VinylPageController: UIViewController {

    init(barControllerFactory: @escaping () -> ShoppingBarControlling = ShoppingBarController.init,
         detailsControllerFactory: @escaping () -> UIViewController = { VinylDetailsController(vinyl: .shotDetails) },
         environment: Environment = .shared) {
        self.barControllerFactory = barControllerFactory
        self.detailsControllerFactory = detailsControllerFactory
        self.environment = environment

        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Children

    lazy var barController: ShoppingBarControlling = barControllerFactory()
    lazy var detailsController: UIViewController = detailsControllerFactory()

    var pageView: VinylPageView! {
        return view as? VinylPageView
    }
    
    // MARK: - Lifecycle

    override func loadView() {
        view = VinylPageView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        embedDetailsController()
        embedBarController()
        setUpBarControlTap()
    }

    // MARK: - Status bar

    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: - Private

    private let barControllerFactory: () -> ShoppingBarControlling
    private let detailsControllerFactory: () -> UIViewController
    private let environment: Environment

    private func embedDetailsController() {
        embed(childViewController: detailsController, inside: pageView.detailsContainerView)
    }

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
