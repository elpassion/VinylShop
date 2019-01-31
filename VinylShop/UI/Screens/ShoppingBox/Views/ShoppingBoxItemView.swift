import Anchorage
import UIKit

class ShoppingBoxItemView: UIView {

    let coverImageView = UIImageView(frame: .zero)
        |> image(#imageLiteral(resourceName: "album_cover"))

    let titleLabel = UILabel(frame: .zero)
        |> text("We the generation")
        <> font(.nunito(.semibold), size: 16.0, color: .whiteFFFFFF)

    let bandLabel = UILabel(frame: .zero)
        |> text("Rudimental")
        <> font(.nunito(.semibold), size: 12.0, color: .whiteFFFFFF, alpha: 0.6)

    let removeButton = UIButton(frame: .zero)
        |> { $0.setImage(#imageLiteral(resourceName: "remove_button"), for: .normal) }

    let separatorView = UIView(frame: .zero)
        |> background(color: .whiteFFFFFF, alpha: 0.3)

    let priceView = ShoppingBoxPriceView()

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private let coverCenterGuide = UILayoutGuide()

    private func addSubviews() {
        [coverImageView, titleLabel, bandLabel, removeButton, separatorView, priceView].forEach(addSubview)
        addLayoutGuide(coverCenterGuide)
    }

    // MARK: - Layout

    private func setUpLayout() {
        coverImageView.topAnchor == topAnchor + 14
        coverImageView.leadingAnchor == leadingAnchor
        coverImageView.sizeAnchors == CGSize(width: 52, height: 52)

        coverCenterGuide.widthAnchor == widthAnchor
        coverCenterGuide.heightAnchor == 1
        coverCenterGuide.centerYAnchor == coverImageView.centerYAnchor
        coverCenterGuide.centerXAnchor == centerXAnchor

        removeButton.sizeAnchors == CGSize(width: 20, height: 20)
        removeButton.trailingAnchor == trailingAnchor
        removeButton.centerYAnchor == centerYAnchor

        titleLabel.bottomAnchor == coverCenterGuide.topAnchor
        titleLabel.leadingAnchor == coverImageView.trailingAnchor + 18
        titleLabel.topAnchor >= topAnchor

        bandLabel.topAnchor == coverCenterGuide.bottomAnchor
        bandLabel.leadingAnchor == titleLabel.leadingAnchor
        bandLabel.bottomAnchor <= bottomAnchor
        bandLabel.trailingAnchor <= titleLabel.trailingAnchor

        separatorView.heightAnchor == 1
        separatorView.bottomAnchor == bottomAnchor
        separatorView.horizontalAnchors == horizontalAnchors
        separatorView.topAnchor == coverImageView.bottomAnchor + 14

        priceView.centerYAnchor == titleLabel.centerYAnchor
        priceView.leadingAnchor == titleLabel.trailingAnchor + 10
        priceView.trailingAnchor <= removeButton.leadingAnchor - 10

        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
