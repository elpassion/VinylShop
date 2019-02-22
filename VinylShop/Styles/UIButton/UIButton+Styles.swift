import UIKit

func title(_ title: String, font: Font, size: CGFloat, color: Color, alpha: CGFloat = 1.0) -> (UIButton) -> Void {
    return { button in
        button.titleLabel?.font = UIFont(name: font.name, size: size)
        button.setTitle(title, for: .normal)
        button.setTitleColor(color.ui(alpha: alpha), for: .normal)
    }
}

func image(_ image: UIImage, states: [UIControl.State] = [.normal]) -> (UIButton) -> Void {
    return { button in
        states.forEach { state in
            button.setImage(image, for: state)
        }
    }
}

func backgroundColor(_ color: Color, alpha: CGFloat = 1.0) -> (UIButton) -> Void {
    return { button in
        button.setBackgroundImage(UIImage.color(color.ui(alpha: alpha)), for: .normal)
    }
}

func flipTitleImage() -> (UIButton) -> Void {
    return { button in
        button.transform = CGAffineTransform(scaleX: -1, y: 1)
        button.titleLabel?.transform = CGAffineTransform(scaleX: -1, y: 1)
        button.imageView?.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
}

func insetContent(top: CGFloat = 0.0,
                  left: CGFloat = 0.0,
                  bottom: CGFloat = 0.0,
                  right: CGFloat = 0.0) -> (UIButton) -> Void {
    return { button in
        button.contentEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}

func insetTitle(top: CGFloat = 0.0,
                left: CGFloat = 0.0,
                bottom: CGFloat = 0.0,
                right: CGFloat = 0.0) -> (UIButton) -> Void {
    return { button in
        button.titleEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}
