import UIKit

extension UICollectionView {

    func visibleCellsPaths<Cell: UICollectionViewCell>(_: Cell.Type) -> [(cell: Cell, path: IndexPath)] {
        return visibleCells
            .compactMap { $0 as? Cell }
            .compactMap { cell in indexPath(for: cell).map { (cell: cell, path: $0) } }
    }

}
