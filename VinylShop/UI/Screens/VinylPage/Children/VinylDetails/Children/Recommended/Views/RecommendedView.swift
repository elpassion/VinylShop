import Anchorage
import UIKit

class RecommendedView: UIView {

    let collectionViewLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)

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
