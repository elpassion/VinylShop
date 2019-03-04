import UIKit

extension UISpringTimingParameters {

    static var headerTiming: UITimingCurveProvider {
        return UISpringTimingParameters(mass: 1, stiffness: 100, damping: 20, initialVelocity: CGVector(dx: 0, dy: 20))
    }

}
