import UIKit

extension UIViewPropertyAnimator {

    convenience init<Context>(duration: Double,
                              curve: UIView.AnimationCurve,
                              keyframes: [Keyframe<Context>],
                              with context: Context) {
        self.init(duration: duration, curve: curve) {
            UIView.keyframeAnimation(duration: duration) {
                keyframes.forEach { $0.play(with: context, totalDuration: duration) }
            }
        }
    }

}
