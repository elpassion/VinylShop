import Anchorage
import UIKit

class ShopView: UIView {
    
    let scrollContentView = UIStackView(frame: .zero)
        |> fillVertical()

    let scrollView = UIScrollView(frame: .zero)
        |> disableScrollIndicators
        <> { $0.contentInsetAdjustmentBehavior = .never }

    init() {
        super.init(frame: .zero)

        setUpSelf()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Configuration

    private func setUpSelf() {
        backgroundColor = Color.whiteFFFFFF.ui()
    }

    // MARK: - Subviews

    private func addSubviews() {
        scrollView.addSubview(scrollContentView)
        addSubview(scrollView)
    }

    // MARK: - Layout

    private func setUpLayout() {
        scrollView.edgeAnchors == edgeAnchors
        
        scrollContentView.edgeAnchors == scrollView.edgeAnchors
        scrollContentView.widthAnchor == scrollView.widthAnchor
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
