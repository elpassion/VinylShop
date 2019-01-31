import Anchorage
import UIKit

class ShoppingBoxFooterView: UIView {

    let totalLabel = UILabel(frame: .zero)
        |> text("Total:")
        <> font(.nunito(.semibold), size: 14, color: .whiteFFFFFF)

    let priceLabel = UILabel(frame: .zero)
        |> text("$30")
        <> font(.nunito(.bold), size: 28, color: .whiteFFFFFF) // FIXME: $ should have a different font

    let checkoutButton = UIButton(frame: .zero)
        |> title("Checkout", font: .nunito(.bold), size: 18, color: .blue2FC5D8)
        <> rounded(radius: 24)
        <> image(#imageLiteral(resourceName: "checkout_arrow"))

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
        [totalLabel, priceLabel, checkoutButton].forEach(addSubview)
    }

    // MARK: - Layout

    private func setUpLayout() {
        totalLabel.leadingAnchor == leadingAnchor
        totalLabel.centerYAnchor == centerYAnchor

        priceLabel.leadingAnchor == totalLabel.trailingAnchor + 9
        priceLabel.centerYAnchor == totalLabel.centerYAnchor

        checkoutButton.trailingAnchor == trailingAnchor
        checkoutButton.verticalAnchors == verticalAnchors
        checkoutButton.heightAnchor == 48
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
