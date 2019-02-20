import UIKit

class ShopController: UIViewController {

    init(vinyl: VinylDetails,
         newFactory: @escaping (VinylDetails) -> UIViewController = newAlbumsControllerFactory(),
         genresFactory: @escaping (VinylDetails) -> UIViewController = { GenresController(vinyl: $0) },
         recommendedFactory: @escaping (VinylDetails) -> UIViewController = recommendedControllerFactory()) {
        self.vinyl = vinyl
        self.newFactory = newFactory
        self.genresFactory = genresFactory
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

        embedChildControllers()
    }

    // MARK: - Private

    private let vinyl: VinylDetails
    private let newFactory: (VinylDetails) -> UIViewController
    private let genresFactory: (VinylDetails) -> UIViewController
    private let recommendedFactory: (VinylDetails) -> UIViewController
    private lazy var newController: UIViewController = newFactory(vinyl)
    private lazy var genresController: UIViewController = genresFactory(vinyl)
    private lazy var recommendedController: UIViewController = recommendedFactory(vinyl)

    private func embedChildControllers() {
        [newController, genresController, recommendedController].forEach { controller in
            embed(childViewController: controller) { view in
                shopView.scrollContentView.addArrangedSubview(view)
            }
        }
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
