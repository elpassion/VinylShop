import Anchorage
import UIKit

class GenreCell: UICollectionViewCell {
 
    let nameLabel: UILabel = UILabel(frame: .zero)
        |> font(.nunito(.semibold), size: 14, color: .black000000)

    let imageView: UIImageView = UIImageView(frame: .zero)

    private let borderedView: UIView = UIView(frame: .zero)
        |> bordered(width: 1, color: .grayB9CAD3)
        <> rounded(radius: 7)

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
        borderedView.addSubview(imageView)
        [nameLabel, borderedView].forEach(addSubview)
    }

    // MARK: - Layout

    private func setUpLayout() {
        borderedView.topAnchor == contentView.topAnchor
        borderedView.horizontalAnchors == contentView.horizontalAnchors
        borderedView.sizeAnchors == CGSize(width: 80, height: 80)

        imageView.centerAnchors == borderedView.centerAnchors

        nameLabel.topAnchor == borderedView.bottomAnchor
        nameLabel.horizontalAnchors == contentView.horizontalAnchors
        nameLabel.bottomAnchor == contentView.bottomAnchor
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
