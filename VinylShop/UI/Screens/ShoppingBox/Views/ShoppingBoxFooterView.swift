import Anchorage
import UIKit

class ShoppingBoxFooterView: UIView {

    let totalLabel = UILabel(frame: .zero)
        |> text("Total:")
        <> font(.nunito(.semibold), size: 14, color: .whiteFFFFFF)

    let priceLabel = UILabel(frame: .zero)
        |> text("<currency>$</currency> <price>30</price>", style: .totalPriceStyle)

    let checkoutButton = UIButton(frame: .zero)
        |> checkoutButtonStyle()

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
        checkoutButton.sizeAnchors == CGSize(width: 180, height: 48)
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
