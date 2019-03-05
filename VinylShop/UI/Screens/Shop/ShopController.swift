import UIKit

class ShopController: UIViewController {

    typealias RecommendedFactory = (ShopDetails) -> VinylCollectionControlling

    init(details: ShopDetails,
         newFactory: @escaping (ShopDetails) -> VinylCollectionControlling = newAlbumsControllerFactory(),
         genresFactory: @escaping (ShopDetails) -> UIViewController = { GenresController(vinyl: $0) },
         recommendedFactory: @escaping RecommendedFactory = shopRecommendedControllerFactory(),
         environment: Environment = .shared) {
        self.details = details
        self.newFactory = newFactory
        self.genresFactory = genresFactory
        self.recommendedFactory = recommendedFactory
        self.environment = environment
        super.init(nibName: nil, bundle: nil)
    }

    var shopView: ShopView {
        return forceCast(view)
    }

    // MARK: - Child controllers

    lazy var newController: VinylCollectionControlling = newFactory(details)
    lazy var genresController: UIViewController = genresFactory(details)
    lazy var recommendedController: VinylCollectionControlling = recommendedFactory(details)

    // MARK: - Lifecycle

    override func loadView() {
        view = ShopView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        embedChildControllers()
        setUpActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        environment.update(barStyle: .default)
    }

    // MARK: - Private

    private let details: ShopDetails
    private let newFactory: (ShopDetails) -> VinylCollectionControlling
    private let genresFactory: (ShopDetails) -> UIViewController
    private let recommendedFactory: RecommendedFactory
    private let environment: Environment

    private func embedChildControllers() {
        [newController, genresController, recommendedController].forEach { controller in
            embed(childViewController: controller) { view in
                shopView.scrollContentView.addArrangedSubview(view)
            }
        }
    }

    private func setUpActions() {
        let vinylSelectedAction: (Vinyl) -> Void = { [weak self] vinyl in
            self?.environment.navigation.go(to: .vinylPage(id: vinyl.id))
        }

        newController.vinylSelectedAction = vinylSelectedAction
        recommendedController.vinylSelectedAction = vinylSelectedAction
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
