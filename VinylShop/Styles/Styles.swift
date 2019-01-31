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
        view.backgroundColor = color.ui(alpha: alpha)
    }
}

func image(_ image: UIImage, mode contentMode: UIView.ContentMode = .scaleAspectFit) -> (UIImageView) -> Void {
    return { imageView in
        imageView.image = image
        imageView.contentMode = contentMode
    }
}

func font(_ font: Font, size: CGFloat, color: Color, alpha: CGFloat = 1.0) -> (UILabel) -> Void {
    return { label in
        label.font = UIFont(name: font.name, size: size)
        label.textColor = color.ui(alpha: alpha)
    }
}

func text(_ text: String) -> (UILabel) -> Void {
    return { label in
        label.text = text
    }
}

func bordered(width: CGFloat, color: Color, alpha: CGFloat = 1.0) -> (UIView) -> Void {
    return { view in
        view.layer.borderWidth = width
        view.layer.borderColor = color.cg(alpha: alpha)
    }
}

func fillVertical(spacing: CGFloat = 0.0) -> (UIStackView) -> Void {
    return { stackView in
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = spacing
    }
}

func title(_ title: String, font: Font, size: CGFloat, color: Color, alpha: CGFloat = 1.0) -> (UIButton) -> Void {
    return { button in
        button.titleLabel?.font = UIFont(name: font.name, size: size)
        button.setTitle(title, for: .normal)
        button.setTitleColor(color.ui(alpha: alpha), for: .normal)
    }
}

func image(_ image: UIImage) -> (UIButton) -> Void {
    return { button in
        button.setImage(image, for: .normal)
    }
}
