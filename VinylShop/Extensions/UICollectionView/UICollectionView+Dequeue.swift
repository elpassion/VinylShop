import UIKit

extension UICollectionView {

    func dequeue<Cell: UICollectionViewCell>(cellFor indexPath: IndexPath, of type: Cell.Type = Cell.self) -> Cell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.reuseID, for: indexPath) as? Cell else {
            fatalError("Cell \(Cell.self) with reuse identifier \(Cell.reuseID) is not registered in a collection view")
        }

        return cell
    }

}
