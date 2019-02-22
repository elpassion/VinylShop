import UIKit

func disableScrollIndicators(_ scrollView: UIScrollView) {
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.showsVerticalScrollIndicator = false
}

func insetContent(top: CGFloat = 0.0,
                  left: CGFloat = 0.0,
                  bottom: CGFloat = 0.0,
                  right: CGFloat = 0.0) -> (UIScrollView) -> Void {
    return { scrollView in
        scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}
