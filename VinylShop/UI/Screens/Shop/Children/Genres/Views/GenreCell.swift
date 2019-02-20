import Anchorage
import UIKit

class GenreCell: UICollectionViewCell {

    let nameLabel: UILabel = UILabel(frame: .zero)
        |> font(.nunito(.semibold), size: 14, color: .black000000)

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
    }

    // MARK: - Layout

    private func setUpLayout() {
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
