import UIKit

extension UICollectionView {

    func cell<Cell: UICollectionViewCell>(
        inSection section: Int,
        atItem item: Int,
        of type: Cell.Type = Cell.self
    ) -> Cell? {
        return dataSource?.collectionView(self, cellForItemAt: IndexPath(item: item, section: section)) as? Cell
    }

}
