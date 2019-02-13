import Anchorage
import UIKit

class VinylDetailsHeaderView: UIView {

    private let coverImageView = UIImageView(frame: .zero)
        |> headerCoverStyle

    private let vinylView = UIImageView(frame: .zero)
        |> image(#imageLiteral(resourceName: "vinyl_record"))

    private let titleLabel = UILabel(frame: .zero)
        |> text("We the Generation")
        <> font(.nunito(.semibold), size: 25, color: .whiteFFFFFF)
        <> multiline()

    private let bandLabel = UILabel(frame: .zero)
        |> text("Rudimental")
        <> font(.nunito(.semibold), size: 14, color: .whiteFFFFFF, alpha: 0.6)

    private let priceView = VinylDetailsHeaderPriceView()

    init() {
        super.init(frame: .zero)

        setUpSelf()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Gradient

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    private var gradientLayer: CAGradientLayer! {
        return layer as? CAGradientLayer
    }

    // MARK: - Configuration

    private func setUpSelf() {
        headerLayerStyle(gradientLayer)
    }

    // MARK: - Subviews

    private func addSubviews() {
        [vinylView, coverImageView, titleLabel, bandLabel, priceView].forEach(addSubview)
    }

    // MARK: - Layout

    private func setUpLayout() {
        [titleLabel, bandLabel].forEach { view in
            view.setContentHuggingPriority(.required, for: .vertical)
        }

        coverImageView.topAnchor == topAnchor + 55
        coverImageView.leadingAnchor == leadingAnchor + 65
        coverImageView.sizeAnchors == CGSize(width: 140, height: 140)

        titleLabel.topAnchor == coverImageView.bottomAnchor + 14
        titleLabel.leadingAnchor == coverImageView.leadingAnchor

        bandLabel.topAnchor == titleLabel.bottomAnchor
        bandLabel.leadingAnchor == titleLabel.leadingAnchor
        bandLabel.bottomAnchor == bottomAnchor - 27

        priceView.trailingAnchor <= trailingAnchor - 27
        priceView.leadingAnchor == titleLabel.trailingAnchor + 12
        priceView.centerYAnchor == titleLabel.centerYAnchor
        priceView.sizeAnchors == CGSize(width: 46, height: 25)

        vinylView.leadingAnchor == coverImageView.leadingAnchor + 35
        vinylView.topAnchor == coverImageView.topAnchor + 4
        vinylView.sizeAnchors == CGSize(width: 166, height: 146)
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
