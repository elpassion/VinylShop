import Anchorage
import UIKit

class VinylPageView: UIView {

    let barContainerView = UIView(frame: .zero)

    init() {
        super.init(frame: .zero)

        setUpSelf()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Configuration

    private func setUpSelf() {
        backgroundColor = .white
    }

    // MARK: - Subviews

    private func addSubviews() {
        addSubview(barContainerView)
    }

    // MARK: - Layout

    private func setUpLayout() {
        barContainerView.horizontalAnchors == horizontalAnchors
        barContainerView.bottomAnchor == bottomAnchor
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
