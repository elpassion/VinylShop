import Anchorage
import UIKit

class VinylDetailsHeaderLargeTitleView: UIView {

    private let titleLabel: UILabel = UILabel(frame: .zero)
        |> text("We the Generation")
        <> font(.nunito(.semibold), size: 25, color: .whiteFFFFFF)
        <> multiline()

    private let bandLabel: UILabel = UILabel(frame: .zero)
        |> text("Rudimental")
        <> font(.nunito(.semibold), size: 14, color: .whiteFFFFFF, alpha: 0.6)

    private let priceView: VinylDetailsHeaderPriceView = VinylDetailsHeaderPriceView()

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
        [titleLabel, bandLabel, priceView].forEach(addSubview)
    }

    // MARK: - Layout

    private func setUpLayout() {
        [titleLabel, bandLabel].forEach { view in
            view.setContentHuggingPriority(.required, for: .vertical)
            view.setContentCompressionResistancePriority(.required, for: .vertical)
        }

        titleLabel.topAnchor == topAnchor
        titleLabel.leadingAnchor == leadingAnchor

        bandLabel.topAnchor == titleLabel.bottomAnchor
        bandLabel.leadingAnchor == titleLabel.leadingAnchor
        bandLabel.bottomAnchor == bottomAnchor

        priceView.trailingAnchor == trailingAnchor
        priceView.leadingAnchor == titleLabel.trailingAnchor + 12
        priceView.centerYAnchor == titleLabel.centerYAnchor
        priceView.sizeAnchors == CGSize(width: 46, height: 25)
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
