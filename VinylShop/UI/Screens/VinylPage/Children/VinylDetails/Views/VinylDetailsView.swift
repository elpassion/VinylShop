import Anchorage
import UIKit

class VinylDetailsView: UIView {

    let scrollContentView = UIStackView(frame: .zero)
        |> fillVertical()

    private let headerView = VinylDetailsHeaderView()
    private let featuresView = VinylDetailsFeaturesView()
    private let notesView = VinylDetailsNotesView()
    private let spacerView = UIView(frame: .zero)

    private let scrollView = UIScrollView(frame: .zero)
        |> disableScrollIndicators

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
        [headerView, featuresView, notesView, spacerView]
            .forEach(scrollContentView.addArrangedSubview)

        scrollView.addSubview(scrollContentView)
        addSubview(scrollView)
    }

    // MARK: - Layout

    private func setUpLayout() {
        spacerView.setContentHuggingPriority(.defaultLow, for: .vertical)
        spacerView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        scrollView.edgeAnchors == edgeAnchors

        scrollContentView.edgeAnchors == scrollView.edgeAnchors
        scrollContentView.widthAnchor == scrollView.widthAnchor
        scrollContentView.heightAnchor >= heightAnchor
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
