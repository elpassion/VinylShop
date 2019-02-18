import UIKit

class VinylPageController: UIViewController {

    init(barControllerFactory: @escaping () -> ShoppingBarControlling = ShoppingBarController.init,
         detailsControllerFactory: @escaping () -> UIViewController = { VinylDetailsController(vinyl: .shotDetails) },
         environment: Environment = .shared,
         buyAnimator: BuyAnimator = BuyAnimator()) {
        self.barControllerFactory = barControllerFactory
        self.detailsControllerFactory = detailsControllerFactory
        self.environment = environment
        self.buyAnimator = buyAnimator

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
        (detailsController.view as? VinylDetailsView)?.headerView.buyButton.addTarget(self, action: #selector(onBuyTap), for: .touchUpInside)
    }

    // MARK: - Status bar

    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: - Private

    private let barControllerFactory: () -> ShoppingBarControlling
    private let detailsControllerFactory: () -> UIViewController
    private let environment: Environment
    private let buyAnimator: BuyAnimator

    private func embedDetailsController() {
        embed(childViewController: detailsController, inside: pageView.detailsContainerView)
    }

    private func embedBarController() {
        barController.view.isHidden = true
        embed(childViewController: barController, inside: pageView.barContainerView)
    }

    private func setUpBarControlTap() {
        barController.barControl.addTarget(self, action: #selector(onBarControlTap), for: .touchUpInside)
    }

    @objc private func onBarControlTap(_: UIControl) {
        environment.presentation.present(context: .shoppingBox)
    }

    @objc private func onBuyTap(_ button: UIButton) {
        guard let detailsView = detailsController.view as? VinylDetailsView,
              let barView = barController.view as? ShoppingBarView else {
            return
        }

        detailsView.headerView.buyButton.isEnabled = false

        buyAnimator.animateBuy(view: view, detailsView: detailsView, barView: barView) {
            detailsView.headerView.buyButton.isEnabled = true
        }
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
