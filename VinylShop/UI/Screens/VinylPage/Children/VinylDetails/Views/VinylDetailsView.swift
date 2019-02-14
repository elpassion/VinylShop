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

    var headerHeightConstraint: NSLayoutConstraint?

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
        [headerPlaceholderView, featuresView, notesView, spacerView]
            .forEach(scrollContentView.addArrangedSubview)

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
        headerHeightConstraint = headerView.heightAnchor == 0

        scrollContentView.edgeAnchors == scrollView.edgeAnchors
        scrollContentView.widthAnchor == scrollView.widthAnchor
        scrollContentView.heightAnchor >= heightAnchor
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
