import Anchorage
import UIKit

class VinylDetailsView: UIView {

    let scrollContentView = UIStackView(frame: .zero)
        |> fillVertical()

    let scrollView = UIScrollView(frame: .zero)
        |> disableScrollIndicators
        <> insetContent(bottom: 80)
        <> { $0.contentInsetAdjustmentBehavior = .never }

    let headerPlaceholderView = VinylDetailsHeaderView()
    let headerView = VinylDetailsHeaderView()
        |> { $0.alpha = 0.0 }

    private let featuresView = VinylDetailsFeaturesView()
    private let notesView = VinylDetailsNotesView()
    private let spacerView = UIView(frame: .zero)

    private var headerHeightConstraint: NSLayoutConstraint?

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Public API

    func apply(headerHeight: VinylDetailsHeaderHeight) {
        headerHeightConstraint?.constant = headerPlaceholderView.frame.size.height * headerHeight.scale
        headerView.apply(headerHeight: headerHeight)
    }

    func showAttachedHeaderView() {
        headerView.alpha = 1.0
        headerPlaceholderView.alpha = 0.0
    }

    // MARK: - Subviews

    private func addSubviews() {
        [headerPlaceholderView, featuresView, notesView, spacerView]
            .reversed()
            .forEach { scrollContentView.insertArrangedSubview($0, at: 0) }

        scrollView.addSubview(scrollContentView)
        [scrollView, headerView].forEach(addSubview)
    }

    // MARK: - Layout

    private func setUpLayout() {
        spacerView.setContentHuggingPriority(.defaultLow, for: .vertical)
        spacerView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        scrollView.edgeAnchors == edgeAnchors

        headerView.topAnchor == topAnchor
        headerView.horizontalAnchors == horizontalAnchors
        headerHeightConstraint = headerView.heightAnchor == 200

        scrollContentView.edgeAnchors == scrollView.edgeAnchors
        scrollContentView.widthAnchor == scrollView.widthAnchor
        scrollContentView.heightAnchor >= heightAnchor
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
