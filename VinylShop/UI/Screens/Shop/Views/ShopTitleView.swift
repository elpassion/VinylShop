import Anchorage
import UIKit

class ShopTitleView: UIView {

    private let titleLabel: UILabel = UILabel(frame: .zero)
        |> font(.nunito(.bold), size: 26, color: .black000000)
        <> text("Explore The Shop")

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
        addSubview(titleLabel)
    }

    // MARK: - Layout

    private func setUpLayout() {
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        titleLabel.topAnchor == topAnchor + 50
        titleLabel.leadingAnchor == leadingAnchor + 64
        titleLabel.trailingAnchor == trailingAnchor
        titleLabel.bottomAnchor == bottomAnchor - 22
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
