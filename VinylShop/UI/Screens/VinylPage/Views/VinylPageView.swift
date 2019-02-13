import Anchorage
import UIKit

class VinylPageView: UIView {

    let detailsContainerView = UIView(frame: .zero)
    let barContainerView = UIView(frame: .zero)

    init() {
        super.init(frame: .zero)

        setUpSelf()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Configuration

    private func setUpSelf() {
        backgroundColor = Color.whiteFFFFFF.ui()
    }

    // MARK: - Subviews

    private func addSubviews() {
        [detailsContainerView, barContainerView].forEach(addSubview)
    }

    // MARK: - Layout

    private func setUpLayout() {
        detailsContainerView.edgeAnchors == edgeAnchors

        barContainerView.horizontalAnchors == horizontalAnchors
        barContainerView.bottomAnchor == bottomAnchor
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
