import UIKit

func register<Cell: UICollectionViewCell>(_ cell: Cell.Type) -> (UICollectionView) -> Void {
    return { collectionView in
        collectionView.register(Cell.self, forCellWithReuseIdentifier: String(describing: Cell.self))
    }
}

func horizontal(_ flowLayout: UICollectionViewFlowLayout) {
    flowLayout.scrollDirection = .horizontal
}

func layoutSpacing(item itemSpacing: CGFloat, line lineSpacing: CGFloat) -> (UICollectionViewFlowLayout) -> Void {
    return { flowLayout in
        flowLayout.minimumInteritemSpacing = itemSpacing
        flowLayout.minimumLineSpacing = lineSpacing
    }
}
