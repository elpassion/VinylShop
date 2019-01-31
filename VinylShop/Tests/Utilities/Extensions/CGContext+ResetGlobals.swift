@testable import VinylShop
import UIKit

extension CGContext {

    static func resetGlobals() {
        evaluateBeginImageContext = UIKit.UIGraphicsBeginImageContextWithOptions
        evaluateEndImageContext = UIKit.UIGraphicsEndImageContext
        evaluateGetCurrentContext = UIKit.UIGraphicsGetCurrentContext
        evaluateGetImageFromCurrentContext = UIKit.UIGraphicsGetImageFromCurrentImageContext
    }

}
