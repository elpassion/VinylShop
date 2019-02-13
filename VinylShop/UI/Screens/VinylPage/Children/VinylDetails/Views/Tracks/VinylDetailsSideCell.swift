import Anchorage
import UIKit

class VinylDetailsSideCell: UICollectionViewCell {

    let titleLabel: UILabel = UILabel(frame: .zero)
        |> background(color: .grayB9CAD3)
        <> rounded(radius: 10)
        <> font(.nunito(.semibold), size: 12, color: .whiteFFFFFF)
        <> alignCenter

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
        contentView.addSubview(titleLabel)
    }

    // MARK: - Layout

    private func setUpLayout() {
        titleLabel.edgeAnchors == edgeAnchors
        titleLabel.heightAnchor == 20
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
