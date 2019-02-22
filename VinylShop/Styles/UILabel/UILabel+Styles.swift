import BonMot
import UIKit

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

func text(_ text: String, style: StringStyle) -> (UILabel) -> Void {
    return { label in
        label.attributedText = text.styled(with: style)
    }
}

func multiline(lines numberOfLines: Int = 0) -> (UILabel) -> Void {
    return { label in
        label.numberOfLines = numberOfLines
        label.lineBreakMode = .byWordWrapping
    }
}

func alignCenter(_ label: UILabel) {
    label.textAlignment = .center
}
