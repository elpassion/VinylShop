import Hue
import UIKit

enum Color: String {
    case black000000 = "#000000"
    case blue269DAC = "#269DAC"
    case blue2FC5D8 = "#2FC5D8"
    case green4BC9AF = "#4BC9AF"
    case grayB9CAD3 = "#B9CAD3"
    case grayD8D8D8 = "#D8D8D8"
    case grayEEF2F5 = "#EEF2F5"
    case purple6B1A3B = "#6B1A3B"
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
