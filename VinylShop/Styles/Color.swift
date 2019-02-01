import Hue
import UIKit

enum Color: String {
    case black000000 = "#000000"
    case blue2FC5D8 = "#2FC5D8"
    case grayD8D8D8 = "#D8D8D8"
    case whiteFFFFFF = "#FFFFFF"
}

extension Color {

    func ui(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(hex: self.rawValue).alpha(alpha)
    }

    func cg(alpha: CGFloat = 1.0) -> CGColor {
        return ui(alpha: alpha).cgColor
    }

}
