import Anchorage
import UIKit

class ShoppingBarView: UIView {

    let frameView = UIView(frame: .zero)
        |> background(color: .blue2FC5D8)
        <> rounded(radius: 15, corners: .top)

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
        addSubview(frameView)
    }

    // MARK: - Layout

    private func setUpLayout() {
        frameView.bottomAnchor == bottomAnchor
        frameView.horizontalAnchors == horizontalAnchors
        frameView.heightAnchor == 100
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
