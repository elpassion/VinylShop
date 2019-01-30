import Anchorage
import UIKit

class ShoppingBoxItemView: UIView {

    let coverImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = #imageLiteral(resourceName: "album_cover")
        view.contentMode = .scaleAspectFit
        return view
    }()

    let titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "We the generation"
        view.textColor = .white

        return view
    }()

    let bandLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Rudimental"
        view.textColor = UIColor.white.withAlphaComponent(0.6)

        return view
    }()

    let removeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(#imageLiteral(resourceName: "remove_button"), for: .normal)

        return button
    }()

    let separatorView = UIView(frame: .zero)
        |> background(color: .grayD8D8D8, alpha: 0.6)

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private let coverCenterGuide = UILayoutGuide()

    private func addSubviews() {
        [coverImageView, titleLabel, bandLabel, removeButton, separatorView].forEach(addSubview)
        addLayoutGuide(coverCenterGuide)
    }

    // MARK: - Layout

    private func setUpLayout() {
        coverImageView.topAnchor == topAnchor
        coverImageView.leadingAnchor == leadingAnchor
        coverImageView.sizeAnchors == CGSize(width: 52, height: 52)

        coverCenterGuide.widthAnchor == widthAnchor
        coverCenterGuide.heightAnchor == 1
        coverCenterGuide.centerYAnchor == coverImageView.centerYAnchor
        coverCenterGuide.centerXAnchor == centerXAnchor

        removeButton.sizeAnchors == CGSize(width: 20, height: 20)
        removeButton.trailingAnchor == trailingAnchor
        removeButton.centerYAnchor == centerYAnchor

        titleLabel.bottomAnchor == coverCenterGuide.topAnchor
        titleLabel.leadingAnchor == coverImageView.trailingAnchor + 18
        titleLabel.topAnchor >= topAnchor

        bandLabel.topAnchor == coverCenterGuide.bottomAnchor
        bandLabel.leadingAnchor == titleLabel.leadingAnchor
        bandLabel.bottomAnchor <= bottomAnchor

        separatorView.heightAnchor == 1
        separatorView.bottomAnchor == bottomAnchor
        separatorView.horizontalAnchors == horizontalAnchors
        separatorView.topAnchor == coverImageView.bottomAnchor + 12
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
