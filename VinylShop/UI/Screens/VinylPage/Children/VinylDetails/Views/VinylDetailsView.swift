import Anchorage
import UIKit

class VinylDetailsView: UIView {

    let scrollContentView = UIStackView(frame: .zero)
        |> fillVertical()

    let scrollView = UIScrollView(frame: .zero)
        |> disableScrollIndicators
        <> insetContent(bottom: 80)
        <> { $0.contentInsetAdjustmentBehavior = .never }

    private let headerView = VinylDetailsHeaderView()
    private let headerPlaceholderView = UIView(frame: .zero)
    private let featuresView = VinylDetailsFeaturesView()
    private let notesView = VinylDetailsNotesView()
    private let spacerView = UIView(frame: .zero)

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

        headerPlaceholderView.heightAnchor == headerView.heightAnchor

        scrollContentView.edgeAnchors == scrollView.edgeAnchors
        scrollContentView.widthAnchor == scrollView.widthAnchor
        scrollContentView.heightAnchor >= heightAnchor
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
