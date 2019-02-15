import Anchorage
import UIKit

private extension CGFloat {

    func size(between minSize: CGSize, and maxSize: CGSize) -> CGSize {
        let width = minSize.width + (maxSize.width - minSize.width) * self
        let height = minSize.height + (maxSize.height - minSize.height) * self
        return CGSize(width: width, height: height)
    }
}

class VinylDetailsHeaderView: UIView {

    let backButton = UIButton(frame: .zero)
        |> image(#imageLiteral(resourceName: "back_arrow"))
        <> insetContent(top: 10, left: 10, bottom: 10, right: 10)

    private let coverImageView = UIImageView(frame: .zero)
        |> headerCoverStyle

    private let vinylView = UIImageView(frame: .zero)
        |> image(#imageLiteral(resourceName: "vinyl_record"))

    private let largeTitleView = VinylDetailsHeaderLargeTitleView()
    private let smallTitleView = VinylDetailsHeaderSmallTitleView()
        |> { $0.isHidden = true }

    private let buyButton = UIButton(frame: .zero)
        |> image(#imageLiteral(resourceName: "buy_button"))

    private let maxCoverSize = CGSize(width: 140, height: 140)
    private let minCoverSize = CGSize(width: 63, height: 63)
    private let vinylOffset: CGFloat = 35

    private var coverSizeConstraint: ConstraintPair?
    private var vinylOffsetConstraint: NSLayoutConstraint?

    init() {
        super.init(frame: .zero)

        setUpSelf()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Public API

    private func scaledPercent(from fromValue: CGFloat, to toValue: CGFloat, progress: CGFloat) -> CGFloat {
        guard fromValue != toValue else { fatalError() }

        let range = toValue - fromValue
        let scaledProgress = (progress - fromValue) / range
        return min(max(scaledProgress, 0.0), 1.0)
    }

    func apply(headerHeight: VinylDetailsHeaderHeight) {
        coverSizeConstraint?.first.constant = headerHeight.scrollProgress.size(between: minCoverSize, and: maxCoverSize).width
        coverSizeConstraint?.second.constant = headerHeight.scrollProgress.size(between: minCoverSize, and: maxCoverSize).height
        vinylOffsetConstraint?.constant = vinylOffset * headerHeight.scale

        largeTitleView.alpha = scaledPercent(from: 0.9, to: 1.0, progress: headerHeight.scrollProgress)
        smallTitleView.alpha = 1 - scaledPercent(from: 0.0, to: 0.1, progress: headerHeight.scrollProgress)
        largeTitleView.isHidden = largeTitleView.alpha == 0.0
        smallTitleView.isHidden = smallTitleView.alpha == 0.0
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
        [vinylView, coverImageView, largeTitleView, smallTitleView, backButton, buyButton].forEach(addSubview)
    }

    // MARK: - Layout

    private func setUpLayout() {
        smallTitleView.setContentHuggingPriority(.defaultLow, for: .horizontal)

        coverImageView.topAnchor == safeAreaLayoutGuide.topAnchor + 35
        coverImageView.leadingAnchor == leadingAnchor + 65
        coverSizeConstraint = (coverImageView.sizeAnchors == maxCoverSize)

        largeTitleView.topAnchor == coverImageView.bottomAnchor + 14 ~ .almostRequired
        largeTitleView.bottomAnchor == bottomAnchor - 27 ~ .almostRequired
        largeTitleView.leadingAnchor == coverImageView.leadingAnchor
        largeTitleView.trailingAnchor <= trailingAnchor - 27

        vinylOffsetConstraint = (vinylView.leadingAnchor == coverImageView.leadingAnchor + vinylOffset)
        vinylView.centerYAnchor == coverImageView.centerYAnchor
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
