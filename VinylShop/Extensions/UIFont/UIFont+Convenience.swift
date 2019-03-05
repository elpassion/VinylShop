import UIKit

extension UIFont {

    static func from(_ font: Font, ofSize size: CGFloat) -> UIFont {
        return openFont(withName: font.name, andSize: size)
    }

}

func openFont(withName name: String, andSize size: CGFloat) -> UIFont {
    guard let font = UIFont(name: name, size: size) else {
        fatalError("Could not open font with name \(name)")
    }

    return font
}
