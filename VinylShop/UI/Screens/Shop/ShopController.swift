import UIKit

class ShopController: UIViewController {

    init(vinyl: VinylDetails,
         newFactory: @escaping (VinylDetails) -> VinylCollectionControlling = newAlbumsControllerFactory(),
         genresFactory: @escaping (VinylDetails) -> UIViewController = { GenresController(vinyl: $0) },
         recommendedFactory: @escaping (VinylDetails) -> VinylCollectionControlling = recommendedControllerFactory(),
         environment: Environment = .shared) {
        self.vinyl = vinyl
        self.newFactory = newFactory
        self.genresFactory = genresFactory
        self.recommendedFactory = recommendedFactory
        self.environment = environment
        super.init(nibName: nil, bundle: nil)
    }

    var shopView: ShopView! {
        return view as? ShopView
    }

    // MARK: - Child controllers

    lazy var newController: VinylCollectionControlling = newFactory(vinyl)
    lazy var genresController: UIViewController = genresFactory(vinyl)
    lazy var recommendedController: VinylCollectionControlling = recommendedFactory(vinyl)

    // MARK: - Lifecycle

    override func loadView() {
        view = ShopView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        embedChildControllers()
        setUpNewVinylSelectedAction()
    }

    // MARK: - Private

    private let vinyl: VinylDetails
    private let newFactory: (VinylDetails) -> VinylCollectionControlling
    private let genresFactory: (VinylDetails) -> UIViewController
    private let recommendedFactory: (VinylDetails) -> VinylCollectionControlling
    private let environment: Environment

    private func embedChildControllers() {
        [newController, genresController, recommendedController].forEach { controller in
            embed(childViewController: controller) { view in
                shopView.scrollContentView.addArrangedSubview(view)
            }
        }
    }

    private func setUpNewVinylSelectedAction() {
        newController.vinylSelectedAction = { [weak self] vinyl in
            self?.environment.navigation.go(to: .vinylPage(id: vinyl.id))
        }
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
