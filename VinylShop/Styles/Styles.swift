import Hue
import UIKit

func rounded(radius: CGFloat, corners: RoundedCorner = .all) -> (UIView) -> Void {
    return { view in
        view.clipsToBounds = true
        view.layer.cornerRadius = radius
        view.layer.maskedCorners = corners.cornerMask
    }
}

func background(color: Color, alpha: CGFloat = 1.0) -> (UIView) -> Void {
    return { view in
        view.backgroundColor = UIColor(hex: color.rawValue).alpha(alpha)
    }
}
