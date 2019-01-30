import Anchorage
import UIKit

class ShoppingBoxSeparatorView: UIView {

    init() {
        super.init(frame: .zero)

        setUpSelf()
        addSubviews()
    }

    // MARK: - Layout subviews

    override func layoutSubviews() {
        super.layoutSubviews()

        shapeLayer.path = UIBezierPath(lineIn: bounds).cgPath
        shapeLayer.lineWidth = bounds.height
    }

    // MARK: - Configuration

    private func setUpSelf() {
        shapeLayer.strokeColor = Color.whiteFFFFFF.cg(alpha: 0.5)
        shapeLayer.lineDashPattern = [4, 5]
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.masksToBounds = false
    }

    // MARK: - Subviews

    private let shapeLayer = CAShapeLayer()

    private func addSubviews() {
        layer.addSublayer(shapeLayer)
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
