import UIKit

extension UIView {

    func converted(_ view: UIView) -> CGRect {
        guard let superview = view.superview else {
            fatalError("Cannot convert rectangle on a view: \(view) with no superview")
        }

        return convert(view.frame, from: superview)
    }

}
