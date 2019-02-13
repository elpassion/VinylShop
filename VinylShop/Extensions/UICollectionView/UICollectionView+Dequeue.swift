import UIKit

extension UICollectionView {

    func cell<Cell: UICollectionViewCell, Model>(
        for indexPath: IndexPath,
        modeling modelAccessor: (IndexPath) -> Model,
        with presenter: (Model, Cell) -> Void
    ) -> Cell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.reuseID, for: indexPath) as? Cell else {
            fatalError("Cell \(Cell.self) with reuse identifier \(Cell.reuseID) is not registered in a collection view")
        }

        let model = modelAccessor(indexPath)
        presenter(model, cell)
        return cell
    }

}
