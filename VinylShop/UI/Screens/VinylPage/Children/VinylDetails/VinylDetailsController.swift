import UIKit

class VinylDetailsController: UIViewController, UIScrollViewDelegate {

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
        setUpScrollViewDelegate()
    }

    // MARK: - UIScrollViewDelegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        detailsView.showAttachedHeaderView()

        if let headerHeight = headerHeight {
            detailsView.apply(headerHeight: headerHeight)
        }
    }

    // MARK: - Private

    private let vinyl: VinylDetails
    private let trackListFactory: (VinylDetails) -> UIViewController
    private let recommendedFactory: (VinylDetails) -> UIViewController
    private lazy var trackListController: UIViewController = trackListFactory(vinyl)
    private lazy var recommendedController: UIViewController = recommendedFactory(vinyl)

    private var collapsedHeaderHeight: CGFloat {
        return 116 + detailsView.safeAreaInsets.top
    }

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

    private func setUpScrollViewDelegate() {
        detailsView.scrollView.delegate = self
    }

    private var headerHeight: VinylDetailsHeaderHeight? {
        let original = detailsView.headerPlaceholderView.frame.height
        let yOffset = detailsView.headerPlaceholderView.frame.maxY - detailsView.scrollView.contentOffset.y
        let current = min(max(yOffset, collapsedHeaderHeight), original)

        return VinylDetailsHeaderHeight(original: original, current: current, minimal: collapsedHeaderHeight)
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
