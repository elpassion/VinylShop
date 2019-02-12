import Anchorage
import UIKit

class VinylDetailsLargeFeatureView: UIView {

    let valueLabel = UILabel(frame: .zero)
        |> font(.nunito(.semibold), size: 30, color: .black000000)

    let subtitleLabel = UILabel(frame: .zero)
        |> font(.nunito(.semibold), size: 12, color: .black000000, alpha: 0.5)

    init(title: String, subtitle: String) {
        super.init(frame: .zero)

        valueLabel.text = title
        subtitleLabel.text = subtitle

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
        addSubview(valueLabel)
        addSubview(subtitleLabel)
    }

    // MARK: - Layout

    private func setUpLayout() {
        [valueLabel, subtitleLabel].forEach { view in
            view.setContentCompressionResistancePriority(.required, for: .vertical)
        }

        valueLabel.topAnchor == topAnchor
        valueLabel.leadingAnchor == leadingAnchor

        subtitleLabel.topAnchor == valueLabel.bottomAnchor + 3
        subtitleLabel.horizontalAnchors == horizontalAnchors
        subtitleLabel.bottomAnchor == bottomAnchor
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
