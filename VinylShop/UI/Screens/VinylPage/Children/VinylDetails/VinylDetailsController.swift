import UIKit

class VinylDetailsController: UIViewController, UIScrollViewDelegate, VinylDetailsControllerProtocol {

    init(vinyl: Vinyl,
         trackListFactory: @escaping (Vinyl) -> UIViewController = { VinylTrackListController(vinyl: $0) },
         recommendedFactory: @escaping (Vinyl) -> UIViewController = vinylRecommendedControllerFactory(),
         calculator: VinylDetailsHeaderAnimationProgressCalculator = VinylDetailsHeaderAnimationProgressCalculator(),
         presenter: VinylDetailsHeaderAnimationPresenter = VinylDetailsHeaderAnimationPresenter()) {
        self.vinyl = vinyl
        self.trackListFactory = trackListFactory
        self.recommendedFactory = recommendedFactory
        self.calculator = calculator
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - VinylDetailsControllerProtocol

    var detailsView: VinylDetailsView {
        return forceCast(view)
    }

    var goBackAction: (() -> Void)?
    var buyAction: (() -> Void)?

    // MARK: - Lifecycle

    override func loadView() {
        view = VinylDetailsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        embedTrackListController()
        embedRecommendedController()
        setUpScrollViewDelegate()
        setUpActions()
    }

    // MARK: - UIScrollViewDelegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollPosition.height > 0.0 {
            let animationProgress = calculator.progress(for: scrollPosition, in: detailsView)
            presenter.present(animation: animationProgress, in: detailsView)
        }
    }

    // MARK: - Private

    private let vinyl: Vinyl
    private let trackListFactory: (Vinyl) -> UIViewController
    private let recommendedFactory: (Vinyl) -> UIViewController
    private let calculator: VinylDetailsHeaderAnimationProgressCalculator
    private let presenter: VinylDetailsHeaderAnimationPresenter
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

    private func setUpScrollViewDelegate() {
        detailsView.scrollView.delegate = self
    }

    private func setUpActions() {
        detailsView.headerView.backButton.addTarget(self, action: #selector(onBackButtonTapped), for: .touchUpInside)
        detailsView.headerView.buyButton.addTarget(self, action: #selector(onBuyTapped), for: .touchUpInside)
    }

    private var scrollPosition: VinylDetailsScrollPosition {
        return VinylDetailsScrollPosition(
            height: detailsView.headerPlaceholderView.frame.height,
            yBottom: detailsView.headerPlaceholderView.frame.maxY,
            yContentOffset: detailsView.scrollView.contentOffset.y,
            topSafeInset: detailsView.safeAreaInsets.top
        )
    }

    @objc
    private func onBackButtonTapped(_: UIButton) {
        goBackAction?()
    }

    @objc
    private func onBuyTapped(_: UIButton) {
        buyAction?()
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
