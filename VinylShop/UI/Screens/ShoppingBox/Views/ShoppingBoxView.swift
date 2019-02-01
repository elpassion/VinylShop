import Anchorage
import Hue
import UIKit

class ShoppingBoxView: UIView {

    let boxView: UIView = UIView(frame: .zero)
        |> background(color: .blue2FC5D8)
        <> rounded(radius: 15, corners: .top)

    let dismissIconView = UIImageView(frame: .zero)
        |> image(#imageLiteral(resourceName: "dismiss_box_arrow"))

    let titleLabel = UILabel(frame: .zero)
        |> text("Shopping Box")
        <> font(.nunito(.semibold), size: 26.0, color: .whiteFFFFFF)

    let dimmedBackgroundView = UIView(frame: .zero)
        |> background(color: .black000000, alpha: 0.4)

    let itemsView = ShoppingBoxItemsView()
    let topSeparatorView = ShoppingBoxSeparatorView()
    let bottomSeparatorView = ShoppingBoxSeparatorView()
    let footerView = ShoppingBoxFooterView()

    let tapGestureRecognizer = UITapGestureRecognizer()

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
        setUpGestureRecognition()
    }

    // MARK: - Subviews

    private func addSubviews() {
        let views: [UIView] = [
            dimmedBackgroundView,
            boxView,
            itemsView,
            dismissIconView,
            titleLabel,
            topSeparatorView,
            bottomSeparatorView,
            footerView
        ]

        views.forEach(addSubview)
    }

    // MARK: - Layout

    private func setUpLayout() {
        dimmedBackgroundView.edgeAnchors == edgeAnchors

        boxView.horizontalAnchors == horizontalAnchors
        boxView.bottomAnchor == bottomAnchor

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
        footerView.bottomAnchor == boxView.bottomAnchor - 30
        footerView.horizontalAnchors == topSeparatorView.horizontalAnchors
    }

    // MARK: - Gestures

    private func setUpGestureRecognition() {
        dimmedBackgroundView.addGestureRecognizer(tapGestureRecognizer)
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
