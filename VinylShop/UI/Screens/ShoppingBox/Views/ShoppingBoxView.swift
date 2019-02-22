import Anchorage
import Hue
import UIKit

class ShoppingBoxView: UIView {

    let boxView: UIView = UIView(frame: .zero)
        |> background(color: .blue2FC5D8)
        <> rounded(radius: 15, corners: .top)

    let dismissIconView: UIImageView = UIImageView(frame: .zero)
        |> image(#imageLiteral(resourceName: "dismiss_box_arrow"))

    let titleLabel: UILabel = UILabel(frame: .zero)
        |> text("Shopping Box")
        <> font(.nunito(.semibold), size: 26.0, color: .whiteFFFFFF)

    let dimmedBackgroundView: UIView = UIView(frame: .zero)
        |> background(color: .black000000, alpha: 0.4)

    let itemsView: ShoppingBoxItemsView = ShoppingBoxItemsView()
    let topSeparatorView: ShoppingBoxSeparatorView = ShoppingBoxSeparatorView()
    let bottomSeparatorView: ShoppingBoxSeparatorView = ShoppingBoxSeparatorView()
    let footerView: ShoppingBoxFooterView = ShoppingBoxFooterView()

    let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    let swipeGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer()
        |> { $0.direction = .down }

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
        setUpGestureRecognition()
    }

    // MARK: - Subviews

    private func addSubviews() {
        [itemsView, dismissIconView, titleLabel, topSeparatorView, bottomSeparatorView, footerView]
            .forEach(boxView.addSubview)

        [dimmedBackgroundView, boxView].forEach(addSubview)
    }

    // MARK: - Layout

    private func setUpLayout() {
        dimmedBackgroundView.edgeAnchors == edgeAnchors

        boxView.horizontalAnchors == horizontalAnchors
        boxView.bottomAnchor == safeAreaLayoutGuide.bottomAnchor + 30

        dismissIconView.sizeAnchors == CGSize(width: 44, height: 11)
        dismissIconView.centerXAnchor == boxView.centerXAnchor
        dismissIconView.topAnchor == boxView.topAnchor + 20

        titleLabel.centerXAnchor == dismissIconView.centerXAnchor
        titleLabel.topAnchor == dismissIconView.bottomAnchor + 30

        topSeparatorView.topAnchor == titleLabel.bottomAnchor + 30
        topSeparatorView.horizontalAnchors == boxView.horizontalAnchors + 20
        topSeparatorView.heightAnchor == 3

        itemsView.horizontalAnchors == topSeparatorView.horizontalAnchors
        itemsView.topAnchor == topSeparatorView.bottomAnchor + 15

        bottomSeparatorView.horizontalAnchors == topSeparatorView.horizontalAnchors
        bottomSeparatorView.topAnchor == itemsView.bottomAnchor + 15
        bottomSeparatorView.heightAnchor == 3

        footerView.topAnchor == bottomSeparatorView.bottomAnchor + 30
        footerView.bottomAnchor == boxView.bottomAnchor - 60
        footerView.horizontalAnchors == topSeparatorView.horizontalAnchors
    }

    // MARK: - Gestures

    private func setUpGestureRecognition() {
        dimmedBackgroundView.addGestureRecognizer(tapGestureRecognizer)
        boxView.addGestureRecognizer(swipeGestureRecognizer)
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
