import Nimble
import UIKit

func embed(controller: UIViewController, in view: UIView) -> Predicate<UIViewController> {
    return Predicate.simple("embed <\(controller)> inside <\(view)>") { actualExpression in
        guard let viewController = try actualExpression.evaluate() else {
            return .fail
        }

        let hasChildController = viewController.children.contains(controller)
        let hasSubview: Bool

        if let stackView = view as? UIStackView {
            hasSubview = stackView.arrangedSubviews.contains(controller.view)
        } else {
            hasSubview = view.subviews.contains(controller.view)
        }

        return PredicateStatus(bool: hasChildController && hasSubview)
    }
}
