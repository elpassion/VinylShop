import UIKit

extension UIStackView {

    func replaceSubviews(with newArrangedSubviews: [UIView]) {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
        newArrangedSubviews.forEach(addArrangedSubview)
    }

}
