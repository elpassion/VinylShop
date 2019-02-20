import Anchorage
import UIKit

class GenresView: UIView {

    let collectionViewLayout = UICollectionViewFlowLayout()
    lazy var collectionView: UICollectionView =
        UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
            |> register(GenreCell.self)

    init() {
        super.init(frame: .zero)

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
