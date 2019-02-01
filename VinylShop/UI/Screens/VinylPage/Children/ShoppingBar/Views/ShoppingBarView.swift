import Anchorage
import UIKit

class ShoppingBarView: UIView {

    let frameControl: UIControl = UIControl(frame: .zero)
        |> background(color: .blue2FC5D8)
        <> rounded(radius: 15, corners: .top)

    let titleLabel = UILabel(frame: .zero)
        |> text("Shopping Box:")
        <> font(.nunito(.semibold), size: 16, color: .whiteFFFFFF)

    let albumCountLabel = UILabel(frame: .zero)
        |> text("<count>1</count> album", style: .albumCountStyle)

    let checkoutBoxView = UIImageView(frame: .zero)
        |> image(#imageLiteral(resourceName: "checkout_box"))

    let albumCoverView = UIImageView(frame: .zero)
        |> image(#imageLiteral(resourceName: "album_cover"))

    let totalLabel = UILabel(frame: .zero)
        |> text("Total: <price>$15</price>", style: .totalPriceSmallStyle)

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private let frameCenterLayoutGuide = UILayoutGuide()

    private func addSubviews() {
        [titleLabel, albumCountLabel, albumCoverView, checkoutBoxView, totalLabel].forEach(frameControl.addSubview)
        addSubview(frameControl)
        addLayoutGuide(frameCenterLayoutGuide)
    }

    // MARK: - Layout

    private func setUpLayout() {
        frameControl.edgeAnchors == edgeAnchors ~ .almostRequired

        frameCenterLayoutGuide.heightAnchor == 0
        frameCenterLayoutGuide.horizontalAnchors == frameControl.horizontalAnchors
        frameCenterLayoutGuide.topAnchor == frameControl.topAnchor + 30
        frameCenterLayoutGuide.bottomAnchor == safeAreaLayoutGuide.bottomAnchor - 30

        checkoutBoxView.leadingAnchor == frameControl.leadingAnchor + 18
        checkoutBoxView.sizeAnchors == CGSize(width: 39, height: 27)
        checkoutBoxView.bottomAnchor == safeAreaLayoutGuide.bottomAnchor - 8

        albumCoverView.sizeAnchors == CGSize(width: 34, height: 34)
        albumCoverView.centerXAnchor == checkoutBoxView.centerXAnchor
        albumCoverView.centerYAnchor == frameCenterLayoutGuide.centerYAnchor - 4

        titleLabel.bottomAnchor == frameCenterLayoutGuide.topAnchor
        titleLabel.leadingAnchor == checkoutBoxView.trailingAnchor + 15
        titleLabel.trailingAnchor <= totalLabel.leadingAnchor - 10

        albumCountLabel.topAnchor == frameCenterLayoutGuide.bottomAnchor
        albumCountLabel.leadingAnchor == titleLabel.leadingAnchor
        albumCountLabel.trailingAnchor <= totalLabel.leadingAnchor - 10

        totalLabel.trailingAnchor == frameControl.trailingAnchor - 22
        totalLabel.centerYAnchor == frameCenterLayoutGuide.centerYAnchor

        totalLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
