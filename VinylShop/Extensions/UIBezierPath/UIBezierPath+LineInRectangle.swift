import UIKit

extension UIBezierPath {

    convenience init(lineIn rect: CGRect) {
        self.init()

        move(to: CGPoint(x: rect.minX, y: rect.midY))
        addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
    }

}
