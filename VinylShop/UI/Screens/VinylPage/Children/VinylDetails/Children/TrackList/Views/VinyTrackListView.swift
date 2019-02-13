import Anchorage
import UIKit

class VinylTrackListView: UIView {

    private let titleLabel = UILabel(frame: .zero)
        |> font(.nunito(.extraBold), size: 12, color: .black000000)
        <> text("TRACKLIST")

    let collectionViewLayout = UICollectionViewFlowLayout()
        |> horizontal
        <> layoutSpacing(item: 0, line: 0)

    lazy var collectionView: UICollectionView =
        UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
            |> background(color: .whiteFFFFFF)
            <> register(VinylSideCell.self)
            <> register(VinylTrackCell.self)
            <> disableScrollIndicators

    var collectionHeightConstraint: NSLayoutConstraint?

    init() {
        super.init(frame: .zero)

        setUpSelf()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Configuration

    private func setUpSelf() {
        backgroundColor = Color.whiteFFFFFF.ui()
    }

    // MARK: - Subviews

    private func addSubviews() {
        [titleLabel, collectionView].forEach(addSubview)
    }

    // MARK: - Layout

    private func setUpLayout() {
        titleLabel.topAnchor == topAnchor + 30
        titleLabel.leadingAnchor == leadingAnchor + 65

        collectionView.topAnchor == titleLabel.bottomAnchor + 23
        collectionView.leadingAnchor == titleLabel.leadingAnchor
        collectionView.trailingAnchor == trailingAnchor
        collectionView.bottomAnchor == bottomAnchor
        collectionHeightConstraint = (collectionView.heightAnchor == 0)
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
