import UIKit

class VinylPageController: UIViewController {

    init(barControllerFactory: @escaping () -> ShoppingBarControlling = ShoppingBarController.init,
         detailsControllerFactory: @escaping () -> VinylDetailsControlling = detailsFactory,
         environment: Environment = .shared,
         buyAnimator: BuyAnimating = BuyAnimator()) {
        self.barControllerFactory = barControllerFactory
        self.detailsControllerFactory = detailsControllerFactory
        self.environment = environment
        self.buyAnimator = buyAnimator

        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Children

    lazy var barController: ShoppingBarControlling = barControllerFactory()
    lazy var detailsController: VinylDetailsControlling = detailsControllerFactory()

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
        setUpActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        environment.update(barStyle: .black)
    }

    // MARK: - Private

    private let barControllerFactory: () -> ShoppingBarControlling
    private let detailsControllerFactory: () -> VinylDetailsControlling
    private let environment: Environment
    private let buyAnimator: BuyAnimating
    private var isAnimating: Bool = false

    private func embedDetailsController() {
        embed(childViewController: detailsController, inside: pageView.detailsContainerView)
    }

    private func embedBarController() {
        barController.view.isHidden = true
        embed(childViewController: barController, inside: pageView.barContainerView)
    }

    private func setUpBarControlTap() {
        barController.barView.frameControl.addTarget(self, action: #selector(onBarControlTap), for: .touchUpInside)
    }

    private func setUpActions() {
        detailsController.goBackAction = { [weak self] in self?.environment.navigation.goBack() }
        detailsController.buyAction = { [weak self] in self?.onBuyTap() }
    }

    @objc private func onBarControlTap(_: UIControl) {
        environment.presentation.present(context: .shoppingBox)
    }

    private func onBuyTap() {
        if !isAnimating {
            isAnimating = true

            buyAnimator.animateBuy(
                view: view,
                detailsView: detailsController.detailsView,
                barView: barController.barView,
                completion: { [weak self] in self?.isAnimating = false }
            )
        }
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}

private func detailsFactory() -> VinylDetailsControlling {
    return VinylDetailsController(vinyl: .shotDetails)
}
