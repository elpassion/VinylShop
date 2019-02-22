import UIKit

func fillVertical(spacing: CGFloat = 0.0) -> (UIStackView) -> Void {
    return { stackView in
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = spacing
    }
}

func fillHorizontal(spacing: CGFloat = 0.0) -> (UIStackView) -> Void {
    return { stackView in
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = spacing
    }
}

func alignBottoms(_ stackView: UIStackView) {
    stackView.alignment = .bottom
}

func alignLeadings(_ stackView: UIStackView) {
    stackView.alignment = .leading
}

func alignCenters(_ stackView: UIStackView) {
    stackView.alignment = .center
}
