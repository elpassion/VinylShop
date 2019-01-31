import UIKit

extension UIFont {

    static func from(_ font: Font, ofSize size: CGFloat) -> UIFont {
        guard let uiFont = UIFont(name: font.name, size: size) else {
            fatalError("Could not load the \(font.name) font")
        }

        return uiFont
    }

}
