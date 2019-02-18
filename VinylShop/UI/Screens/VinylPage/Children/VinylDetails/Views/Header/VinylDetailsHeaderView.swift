import Anchorage
import UIKit

class VinylDetailsHeaderView: UIView {
    
    // MARK: - Sizes

    static let maxCoverSize = CGSize(width: 140, height: 140)
    static let minCoverSize = CGSize(width: 63, height: 63)
    static let maxVinylCenterOffset: CGFloat = 45
    
    // MARK: - Subviews

    let largeTitleView = VinylDetailsHeaderLargeTitleView()
    let smallTitleView = VinylDetailsHeaderSmallTitleView()
        |> { $0.alpha = 0.0 }

    let buyButton = UIButton(frame: .zero)
        |> image(#imageLiteral(resourceName: "buy_button"))

    let backButton = UIButton(frame: .zero)
        |> image(#imageLiteral(resourceName: "back_arrow"))
        <> insetContent(top: 10, left: 10, bottom: 10, right: 10)

    let coverImageView = UIImageView(frame: .zero)
        |> headerCoverStyle

    let vinylView = UIImageView(frame: .zero)
        |> image(#imageLiteral(resourceName: "vinyl_record"))

    // MARK: - Constraints

    var coverSizeConstraint: ConstraintPair?
    var vinylCenterOffsetConstraint: NSLayoutConstraint?

    init() {
        super.init(frame: .zero)

        setUpSelf()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Hit test

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if buyButton.frame.contains(point) {
            return true
        } else {
            return super.point(inside: point, with: event)
        }
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
        [largeTitleView, smallTitleView, backButton, buyButton, vinylView, coverImageView].forEach(addSubview)
    }

    // MARK: - Layout

    private func setUpLayout() {
        smallTitleView.setContentHuggingPriority(.defaultLow, for: .horizontal)

        coverImageView.topAnchor == safeAreaLayoutGuide.topAnchor + 35
        coverImageView.leadingAnchor == leadingAnchor + 65
        coverSizeConstraint = (coverImageView.sizeAnchors == VinylDetailsHeaderView.maxCoverSize)

        largeTitleView.topAnchor == coverImageView.bottomAnchor + 14 ~ .almostRequired
        largeTitleView.bottomAnchor == bottomAnchor - 27 ~ .almostRequired
        largeTitleView.leadingAnchor == coverImageView.leadingAnchor
        largeTitleView.trailingAnchor <= trailingAnchor - 27

        vinylCenterOffsetConstraint = (
            vinylView.centerXAnchor == coverImageView.centerXAnchor + VinylDetailsHeaderView.maxVinylCenterOffset
        )

        vinylView.centerYAnchor == coverImageView.centerYAnchor + 3
        vinylView.heightAnchor == coverImageView.heightAnchor * (146.0 / 140.0)
        vinylView.widthAnchor == coverImageView.widthAnchor * (166.0 / 140.0)

        backButton.sizeAnchors == CGSize(width: 40, height: 36)
        backButton.leadingAnchor == leadingAnchor + 13
        backButton.topAnchor == safeAreaLayoutGuide.topAnchor + 38

        smallTitleView.topAnchor == safeAreaLayoutGuide.topAnchor + 29
        smallTitleView.leadingAnchor == backButton.trailingAnchor + 105
        smallTitleView.trailingAnchor == trailingAnchor - 20
        smallTitleView.bottomAnchor == bottomAnchor - 10

        buyButton.trailingAnchor == trailingAnchor - 6
        buyButton.bottomAnchor == bottomAnchor + 48
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
