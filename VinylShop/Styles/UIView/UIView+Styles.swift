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
        view.backgroundColor = color.ui(alpha: alpha)
    }
}

func bordered(width: CGFloat, color: Color, alpha: CGFloat = 1.0) -> (UIView) -> Void {
    return { view in
        view.layer.borderWidth = width
        view.layer.borderColor = color.cg(alpha: alpha)
    }
}

func shadow(color: Color,
            alpha: CGFloat = 1.0,
            x: CGFloat = 0.0,
            y: CGFloat = 0.0,
            blur: CGFloat = 0.0,
            spread: CGFloat = 0.0) -> (UIView) -> Void {
    return { view in
        let path = UIBezierPath(rect: view.bounds.insetBy(dx: -spread, dy: -spread))

        view.layer.shadowColor = color.cg(alpha: alpha)
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: x, height: y)
        view.layer.shadowRadius = blur * 0.5
        view.layer.shadowPath = path.cgPath
    }
}
