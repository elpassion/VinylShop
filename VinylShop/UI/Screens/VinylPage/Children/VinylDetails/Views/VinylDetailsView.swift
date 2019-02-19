import Anchorage
import UIKit

class VinylDetailsView: UIView {
    
    // MARK: - Subviews

    let scrollContentView = UIStackView(frame: .zero)
        |> fillVertical()

    let scrollView = UIScrollView(frame: .zero)
        |> disableScrollIndicators
        <> insetContent(bottom: 80)
        <> { $0.contentInsetAdjustmentBehavior = .never }

    let headerPlaceholderView = VinylDetailsHeaderView()
        |> { $0.alpha = 0.0 }

    let headerView = VinylDetailsHeaderView()

    private let featuresView = VinylDetailsFeaturesView()
    private let notesView = VinylDetailsNotesView()
    private let spacerView = UIView(frame: .zero)
    
    // MARK: - Constraints

    var headerHeightConstraint: NSLayoutConstraint?

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
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
        scrollView.edgeAnchors == edgeAnchors

        headerView.topAnchor == topAnchor
        headerView.horizontalAnchors == horizontalAnchors
        headerHeightConstraint = (headerView.heightAnchor == headerPlaceholderView.heightAnchor)

        scrollContentView.edgeAnchors == scrollView.edgeAnchors
        scrollContentView.widthAnchor == scrollView.widthAnchor
        scrollContentView.heightAnchor >= heightAnchor
        
        spacerView.heightAnchor == 0 ~ .low
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
