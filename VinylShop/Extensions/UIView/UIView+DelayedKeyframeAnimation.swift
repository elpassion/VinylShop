import UIKit

extension UIView {

    static func delayedKeyframeAnimation(relativeDuration: Double,
                                         totalDuration: Double,
                                         delay: Double,
                                         animations: @escaping () -> Void) {
        UIView.keyframeAnimation(duration: totalDuration) {
            UIView.addKeyframe(
                withRelativeStartTime: delay / totalDuration,
                relativeDuration: relativeDuration,
                animations: animations
            )
        }
    }

}
