import Hue
import UIKit

func rounded(radius: CGFloat, corners: RoundedCorner = .all) -> (UIView) -> Void {
    return { view in
        view.clipsToBounds = true
        view.layer.cornerRadius = radius
        view.layer.maskedCorners = corners.cornerMask
    }
}

func background(color hex: String) -> (UIView) -> Void {
    return { view in
        view.backgroundColor = UIColor(hex: hex)
    }
}
