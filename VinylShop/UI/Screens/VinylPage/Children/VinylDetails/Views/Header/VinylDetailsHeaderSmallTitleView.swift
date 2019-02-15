import Anchorage
import UIKit

class VinylDetailsHeaderSmallTitleView: UIView {

    private let titleLabel = UILabel(frame: .zero)
        |> text("We the Generation")
        <> font(.nunito(.semibold), size: 18, color: .whiteFFFFFF)
        <> multiline()

    private let bandLabel = UILabel(frame: .zero)
        |> text("Rudimental")
        <> font(.nunito(.semibold), size: 12, color: .whiteFFFFFF, alpha: 0.6)

    private let priceView = ShoppingBoxPriceView()

    private let topLineStackView = UIStackView(frame: .zero)
        |> fillHorizontal(spacing: 9)
        <> alignCenters

    private let stackView = UIStackView(frame: .zero)
        |> fillVertical()
        <> alignLeadings

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
        [titleLabel, priceView].forEach(topLineStackView.addArrangedSubview)
        [topLineStackView, bandLabel].forEach(stackView.addArrangedSubview)
        addSubview(stackView)
    }

    // MARK: - Layout

    private func setUpLayout() {
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        bandLabel.setContentHuggingPriority(.required, for: .vertical)
        bandLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        bandLabel.setContentHuggingPriority(.required, for: .horizontal)
        bandLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        priceView.sizeAnchors == CGSize(width: 38, height: 20)

        stackView.topAnchor == topAnchor
        stackView.leadingAnchor == leadingAnchor
        stackView.trailingAnchor <= trailingAnchor
        stackView.bottomAnchor <= bottomAnchor
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
