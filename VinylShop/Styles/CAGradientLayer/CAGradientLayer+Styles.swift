import UIKit

func gradient(colors: Color...) -> (CAGradientLayer) -> Void {
    return { gradientLayer in
        gradientLayer.colors = colors.map { $0.cg() }
    }
}

func startPoint(x: CGFloat, y: CGFloat) -> (CAGradientLayer) -> Void {
    return { gradientLayer in
        gradientLayer.startPoint = CGPoint(x: x, y: y)
    }
}

func endPoint(x: CGFloat, y: CGFloat) -> (CAGradientLayer) -> Void {
    return { gradientLayer in
        gradientLayer.endPoint = CGPoint(x: x, y: y)
    }
}
