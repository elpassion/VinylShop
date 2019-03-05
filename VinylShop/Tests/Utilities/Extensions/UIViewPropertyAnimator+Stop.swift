import UIKit

extension UIViewPropertyAnimator {

    func stop() {
        pauseAnimation()
        stopAnimation(false)
        finishAnimation(at: .current)
    }

}
