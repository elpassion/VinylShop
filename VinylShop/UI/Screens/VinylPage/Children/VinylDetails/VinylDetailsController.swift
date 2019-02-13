import UIKit

class VinylDetailsController: UIViewController {

    init(vinyl: VinylDetails,
         trackListFactory: @escaping (VinylDetails) -> UIViewController = { VinylTrackListController(vinyl: $0) }) {
        self.vinyl = vinyl
        self.trackListFactory = trackListFactory

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
    }

    // MARK: - Private

    private let vinyl: VinylDetails
    private let trackListFactory: (VinylDetails) -> UIViewController
    private lazy var trackListController: UIViewController = trackListFactory(vinyl)

    private func embedTrackListController() {
        embed(childViewController: trackListController) { view in
            detailsView.scrollContentView.insertArrangedSubview(view, at: 2)
        }
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
