import Anchorage
import UIKit

class ShoppingBoxPriceView: UIView {

    let frameView = UIView(frame: .zero)
        |> bordered(width: 1, color: .whiteFFFFFF, alpha: 0.5)
        <> rounded(radius: 3.0)

    let currencyLabel = UILabel(frame: .zero)
        |> text("$")
        <> font(.nunito(.bold), size: 10.0, color: .whiteFFFFFF)

    let priceLabel = UILabel(frame: .zero)
        |> text("15")
        <> font(.nunito(.bold), size: 14.0, color: .whiteFFFFFF)

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
        [frameView, currencyLabel, priceLabel].forEach(addSubview)
    }

    // MARK: - Layout

    private func setUpLayout() {
        frameView.edgeAnchors == edgeAnchors

        currencyLabel.leadingAnchor == frameView.leadingAnchor + 6
        currencyLabel.centerYAnchor == frameView.centerYAnchor

        priceLabel.verticalAnchors == frameView.verticalAnchors + 1
        priceLabel.leadingAnchor == currencyLabel.trailingAnchor + 3
        priceLabel.trailingAnchor == frameView.trailingAnchor - 6
        priceLabel.centerYAnchor == currencyLabel.centerYAnchor
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
