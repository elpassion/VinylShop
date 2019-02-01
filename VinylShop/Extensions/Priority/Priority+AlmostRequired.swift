import Anchorage
import UIKit

extension Priority {

    static var almostRequired: Priority {
        return .custom(UILayoutPriority(999))
    }

}
