import Anchorage
import UIKit

class VinylDetailsTrackListView: UIView {

    private let titleLabel = UILabel(frame: .zero)
        |> font(.nunito(.extraBold), size: 12, color: .black000000)
        <> text("TRACKLIST")

    let collectionViewLayout = UICollectionViewFlowLayout()

    lazy var collectionView: UICollectionView =
        UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
            |> background(color: .whiteFFFFFF)
            <> register(VinylDetailsSideCell.self)
            <> register(VinylDetailsTrackCell.self)

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
        collectionView.heightAnchor == 270
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
