import UIKit

class ShopController: UIViewController {

    init(vinyl: VinylDetails,
         newFactory: @escaping (VinylDetails) -> UIViewController = newAlbumsControllerFactory(),
         recommendedFactory: @escaping (VinylDetails) -> UIViewController = recommendedControllerFactory()) {
        self.vinyl = vinyl
        self.newFactory = newFactory
        self.recommendedFactory = recommendedFactory
        super.init(nibName: nil, bundle: nil)
    }

    var shopView: ShopView! {
        return view as? ShopView
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = ShopView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        embedNewController()
        embedRecommendedController()
    }

    // MARK: - Private

    private let vinyl: VinylDetails
    private let newFactory: (VinylDetails) -> UIViewController
    private let recommendedFactory: (VinylDetails) -> UIViewController
    private lazy var newController: UIViewController = newFactory(vinyl)
    private lazy var recommendedController: UIViewController = recommendedFactory(vinyl)

    private func embedNewController() {
        embed(childViewController: newController) { view in
            shopView.scrollContentView.addArrangedSubview(view)
        }
    }

    private func embedRecommendedController() {
        embed(childViewController: recommendedController) { view in
            shopView.scrollContentView.addArrangedSubview(view)
        }
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
