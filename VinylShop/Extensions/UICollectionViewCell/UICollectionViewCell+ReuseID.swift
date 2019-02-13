import UIKit

extension UICollectionViewCell {

    static var reuseID: String {
        return String(describing: self)
    }

}
