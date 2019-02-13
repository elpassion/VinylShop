import Anchorage
import UIKit

class VinylDetailsHeaderView: UIView {

    init() {
        super.init(frame: .zero)

        setUpSelf()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Gradient

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    private var gradientLayer: CAGradientLayer! {
        return layer as? CAGradientLayer
    }

    // MARK: - Configuration

    private func setUpSelf() {
        headerLayerStyle(gradientLayer)
    }

    // MARK: - Subviews

    private func addSubviews() {
    }

    // MARK: - Layout

    private func setUpLayout() {

    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
