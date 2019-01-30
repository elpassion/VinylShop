import Anchorage
import Hue
import UIKit

class ShoppingBoxView: UIView {

    let boxView: UIView = UIView(frame: .zero)
        |> rounded(radius: 15, corners: .top)
        <> { $0.backgroundColor = UIColor(hex: "#2FC5D8") }

    init() {
        super.init(frame: .zero)

        setUpSelf()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Configuration

    private func setUpSelf() {
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }

    // MARK: - Subviews

    private func addSubviews() {
        addSubview(boxView)
    }

    // MARK: - Layout

    private func setUpLayout() {
        boxView.heightAnchor == heightAnchor * 0.6
        boxView.horizontalAnchors == horizontalAnchors
        boxView.bottomAnchor == bottomAnchor
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
