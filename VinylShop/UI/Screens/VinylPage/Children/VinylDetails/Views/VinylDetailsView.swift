import Anchorage
import UIKit

class VinylDetailsView: UIView {

    let trackListView = VinylDetailsTrackListView()

    private let headerView = VinylDetailsHeaderView()
    private let featuresView = VinylDetailsFeaturesView()
    private let notesView = VinylDetailsNotesView()
    private let recommendationsView = VinylDetailsRecommendationsView()
    private let spacerView = UIView(frame: .zero)

    private let scrollView = UIScrollView(frame: .zero)
    private let scrollContent = UIStackView(frame: .zero)
        |> fillVertical()

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
        [headerView, featuresView, trackListView, notesView, recommendationsView, spacerView]
            .forEach(scrollContent.addArrangedSubview)

        scrollView.addSubview(scrollContent)
        addSubview(scrollView)
    }

    // MARK: - Layout

    private func setUpLayout() {
        spacerView.setContentHuggingPriority(.defaultLow, for: .vertical)
        spacerView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        headerView.heightAnchor == 150
        recommendationsView.heightAnchor == 95

        scrollView.edgeAnchors == edgeAnchors

        scrollContent.edgeAnchors == scrollView.edgeAnchors
        scrollContent.widthAnchor == scrollView.widthAnchor
        scrollContent.heightAnchor >= heightAnchor
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
