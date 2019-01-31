import Nimble
import UIKit

func beImage(_ expectedImage: UIImage) -> Predicate<UIImage> {
    return Predicate.simple("equal <\(expectedImage)") { actualExpression in
        guard let receivedImage = try actualExpression.evaluate() else {
            return .fail
        }

        return PredicateStatus(bool: expectedImage.pngData() == receivedImage.pngData())
    }
}
