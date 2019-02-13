import UIKit

class VinylDetailsController: UIViewController {

    init(vinyl: VinylDetails,
         trackListFactory: @escaping (VinylDetails) -> UIViewController = { VinylTrackListController(vinyl: $0) },
         recommendedFactory: @escaping (VinylDetails) -> UIViewController = { RecommendedController(vinyl: $0) }) {
        self.vinyl = vinyl
        self.trackListFactory = trackListFactory
        self.recommendedFactory = recommendedFactory

        super.init(nibName: nil, bundle: nil)
    }

    var detailsView: VinylDetailsView! {
        return view as? VinylDetailsView
    }
    
    // MARK: - Lifecycle

    override func loadView() {
        view = VinylDetailsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        embedTrackListController()
        embedRecommendedController()
    }

    // MARK: - Private

    private let vinyl: VinylDetails
    private let trackListFactory: (VinylDetails) -> UIViewController
    private let recommendedFactory: (VinylDetails) -> UIViewController
    private lazy var trackListController: UIViewController = trackListFactory(vinyl)
    private lazy var recommendedController: UIViewController = recommendedFactory(vinyl)

    private func embedTrackListController() {
        embed(childViewController: trackListController) { view in
            detailsView.scrollContentView.insertArrangedSubview(view, at: 2)
        }
    }

    private func embedRecommendedController() {
        embed(childViewController: recommendedController) { view in
            detailsView.scrollContentView.insertArrangedSubview(view, at: 4)
        }
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
