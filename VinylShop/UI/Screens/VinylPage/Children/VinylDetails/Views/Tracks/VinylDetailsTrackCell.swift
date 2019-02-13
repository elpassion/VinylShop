import Anchorage
import UIKit

class VinylDetailsTrackCell: UICollectionViewCell {

    let positionLabel: UILabel = UILabel(frame: .zero)
        |> background(color: .grayB9CAD3)
        <> rounded(radius: 10)
        <> font(.nunito(.semibold), size: 12, color: .whiteFFFFFF)
        <> alignCenter

    let nameLabel: UILabel = UILabel(frame: .zero)
        |> background(color: .grayB9CAD3)
        <> rounded(radius: 10)
        <> font(.nunito(.semibold), size: 12, color: .whiteFFFFFF)
        <> alignCenter

    let durationLabel: UILabel = UILabel(frame: .zero)
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
    }

    // MARK: - Layout

    private func setUpLayout() {
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
