import Anchorage
import UIKit

class VinylCollectionCell: UICollectionViewCell {

    let titleLabel: UILabel = UILabel(frame: .zero)
        |> font(.nunito(.semibold), size: 14, color: .black000000)
        <> multiline(lines: 2)

    let bandLabel: UILabel = UILabel(frame: .zero)
        |> font(.nunito(.semibold), size: 10, color: .black000000, alpha: 0.6)

    let coverImageView = UIImageView(frame: .zero)
        |> image(#imageLiteral(resourceName: "cover_metallica"), mode: .scaleAspectFit)

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
        [titleLabel, bandLabel, coverImageView].forEach(contentView.addSubview)
    }

    // MARK: - Layout

    private func setUpLayout() {
        [titleLabel, bandLabel].forEach { label in
            label.setContentHuggingPriority(.required, for: .vertical)
        }

        coverImageView.horizontalAnchors == contentView.horizontalAnchors
        coverImageView.topAnchor == contentView.topAnchor
        coverImageView.heightAnchor == coverImageView.widthAnchor

        titleLabel.horizontalAnchors == contentView.horizontalAnchors
        titleLabel.topAnchor == coverImageView.bottomAnchor + 8

        bandLabel.horizontalAnchors == titleLabel.horizontalAnchors
        bandLabel.topAnchor >= titleLabel.bottomAnchor + 4
        bandLabel.bottomAnchor == contentView.bottomAnchor
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
