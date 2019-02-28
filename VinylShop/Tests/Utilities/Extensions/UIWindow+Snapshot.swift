import UIKit

extension UIWindow {

    var snapshot: UIImage {
        return UIGraphicsImageRenderer(bounds: bounds).image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }

}
