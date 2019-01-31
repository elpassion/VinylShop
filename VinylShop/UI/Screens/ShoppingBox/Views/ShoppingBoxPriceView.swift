import Anchorage
import UIKit

class ShoppingBoxPriceView: UIView {

    let frameView = UIView(frame: .zero)
        |> bordered(width: 1, color: .whiteFFFFFF, alpha: 0.5)
        <> rounded(radius: 3.0)

    let priceLabel = UILabel(frame: .zero)
        |> text("<currency>$</currency> <price>15</price>", style: .itemPriceStyle)

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
        [frameView, priceLabel].forEach(addSubview)
    }

    // MARK: - Layout

    private func setUpLayout() {
        frameView.edgeAnchors == edgeAnchors

        priceLabel.verticalAnchors == frameView.verticalAnchors + 1
        priceLabel.leadingAnchor == frameView.leadingAnchor + 6
        priceLabel.trailingAnchor == frameView.trailingAnchor - 6
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
