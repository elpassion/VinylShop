import Anchorage
import UIKit

class VinylTrackCell: UICollectionViewCell {

    let positionLabel: UILabel = UILabel(frame: .zero)
        |> font(.nunito(.semibold), size: 12, color: .black000000, alpha: 0.5)

    let nameLabel: UILabel = UILabel(frame: .zero)
        |> font(.nunito(.semibold), size: 16, color: .black000000)

    let durationLabel: UILabel = UILabel(frame: .zero)
        |> font(.nunito(.semibold), size: 12, color: .black000000, alpha: 0.5)

    private let separatorView: UIView = UIView(frame: .zero)
        |> background(color: .black000000, alpha: 0.1)

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
        [positionLabel, nameLabel, durationLabel, separatorView].forEach(contentView.addSubview)
    }

    // MARK: - Layout

    private func setUpLayout() {
        [positionLabel, durationLabel].forEach { label in
            label.setContentHuggingPriority(.required, for: .horizontal)
        }

        positionLabel.leadingAnchor == contentView.leadingAnchor + 4
        positionLabel.centerYAnchor == nameLabel.centerYAnchor

        nameLabel.leadingAnchor == positionLabel.trailingAnchor + 11
        nameLabel.centerYAnchor == contentView.centerYAnchor

        durationLabel.leadingAnchor == nameLabel.trailingAnchor + 17
        durationLabel.trailingAnchor == contentView.trailingAnchor
        durationLabel.centerYAnchor == nameLabel.centerYAnchor

        separatorView.bottomAnchor == contentView.bottomAnchor
        separatorView.heightAnchor == 1
        separatorView.horizontalAnchors == contentView.horizontalAnchors
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
