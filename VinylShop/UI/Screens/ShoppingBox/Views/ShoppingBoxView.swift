import Anchorage
import Hue
import UIKit

class ShoppingBoxView: UIView {

    let boxView: UIView = UIView(frame: .zero)
        |> background(color: .blue2FC5D8)
        <> rounded(radius: 15, corners: .top)

    let dismissIconView = UIImageView(frame: .zero)
        |> image(#imageLiteral(resourceName: "dismiss_box_arrow"))

    let itemView = ShoppingBoxItemView()

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
        [boxView, itemView, dismissIconView].forEach(addSubview)
    }

    // MARK: - Layout

    private func setUpLayout() {
        boxView.heightAnchor == heightAnchor * 0.6
        boxView.horizontalAnchors == horizontalAnchors
        boxView.bottomAnchor == bottomAnchor

        itemView.horizontalAnchors == boxView.horizontalAnchors + 20
        itemView.centerAnchors == boxView.centerAnchors

        dismissIconView.sizeAnchors == CGSize(width: 44, height: 11)
        dismissIconView.centerXAnchor == boxView.centerXAnchor
        dismissIconView.topAnchor == boxView.topAnchor + 20
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
