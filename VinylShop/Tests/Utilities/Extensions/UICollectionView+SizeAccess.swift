import UIKit

extension UICollectionView {

    func size(inSection section: Int, atItem item: Int) -> CGSize {
        guard let flowLayoutDelegate = delegate as? UICollectionViewDelegateFlowLayout else {
            return .zero
        }

        let path = IndexPath(item: item, section: section)
        return flowLayoutDelegate.collectionView?(self, layout: self.collectionViewLayout, sizeForItemAt: path) ?? .zero
    }

}
