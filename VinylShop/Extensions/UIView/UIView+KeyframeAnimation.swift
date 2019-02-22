import UIKit

extension UIView {

    static func keyframeAnimation(duration: TimeInterval, animations: @escaping () -> Void) {
        animateKeyframes(withDuration: duration, delay: 0, animations: animations)
    }

}
