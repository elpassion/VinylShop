import Anchorage
import UIKit

class VinylDetailsGenreView: UIView {

    let iconView = UIImageView(frame: .zero)
        |> image(#imageLiteral(resourceName: "genre_rock_small"))

    let titleLabel = UILabel(frame: .zero)
        |> font(.nunito(.semibold), size: 13, color: .black000000)
        <> text("ROCK")

    let subtitleLabel = UILabel(frame: .zero)
        |> font(.nunito(.semibold), size: 12, color: .black000000, alpha: 0.5)
        <> text("Genre")

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
        [iconView, titleLabel, subtitleLabel].forEach(addSubview)
    }

    // MARK: - Layout

    private func setUpLayout() {
        [titleLabel, subtitleLabel].forEach { view in
            view.setContentCompressionResistancePriority(.required, for: .vertical)
        }

        iconView.setContentHuggingPriority(.defaultLow, for: .vertical)

        iconView.topAnchor == topAnchor
        iconView.leadingAnchor == leadingAnchor
        iconView.sizeAnchors == CGSize(width: 22, height: 22)

        subtitleLabel.topAnchor == iconView.bottomAnchor + 12
        subtitleLabel.leadingAnchor == iconView.leadingAnchor
        subtitleLabel.bottomAnchor == bottomAnchor

        titleLabel.leadingAnchor == iconView.trailingAnchor + 3
        titleLabel.centerYAnchor == iconView.centerYAnchor
        titleLabel.trailingAnchor == trailingAnchor
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
