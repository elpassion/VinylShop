import Anchorage
import Hue
import UIKit

class ShoppingBoxView: UIView {

    let boxView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(hex: "#2FC5D8")
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        return view
    }()

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
