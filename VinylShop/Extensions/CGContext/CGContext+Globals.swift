import UIKit

var evaluateBeginImageContext: (CGSize, Bool, CGFloat) -> Void = UIKit.UIGraphicsBeginImageContextWithOptions
var evaluateEndImageContext: () -> Void = UIKit.UIGraphicsEndImageContext
var evaluateGetCurrentContext: () -> CGContext? = UIKit.UIGraphicsGetCurrentContext
var evaluateGetImageFromCurrentContext: () -> UIKit.UIImage? = UIKit.UIGraphicsGetImageFromCurrentImageContext

func UIGraphicsBeginImageContextWithOptions(_ size: CGSize, _ opaque: Bool, _ scale: CGFloat) {
    evaluateBeginImageContext(size, opaque, scale)
}

func UIGraphicsEndImageContext() {
    evaluateEndImageContext()
}

func UIGraphicsGetCurrentContext() -> CGContext? {
    return evaluateGetCurrentContext()
}

func UIGraphicsGetImageFromCurrentImageContext() -> UIKit.UIImage? {
    return evaluateGetImageFromCurrentContext()
}
