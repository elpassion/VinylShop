import Anchorage
import UIKit

class ShoppingBoxItemsView: UIView {

    let stackView: UIStackView = UIStackView(frame: .zero)
        |> fillVertical()

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
    }

    private let itemView: ShoppingBoxItemView = ShoppingBoxItemView()

    // MARK: - Subviews

    private func addSubviews() {
        stackView.addArrangedSubview(itemView)
        addSubview(stackView)
    }

    // MARK: - Layout

    private func setUpLayout() {
        stackView.edgeAnchors == edgeAnchors
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
