import UIKit

class VinylPageController: UIViewController {

    init(barControllerFactory: @escaping () -> ShoppingBarControlling = ShoppingBarController.init,
         detailsControllerFactory: @escaping () -> UIViewController = { VinylDetailsController(vinyl: .shotDetails) },
         environment: Environment = .shared) {
        self.barControllerFactory = barControllerFactory
        self.detailsControllerFactory = detailsControllerFactory
        self.environment = environment

        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Children

    lazy var barController: ShoppingBarControlling = barControllerFactory()
    lazy var detailsController: UIViewController = detailsControllerFactory()

    var pageView: VinylPageView! {
        return view as? VinylPageView
    }
    
    // MARK: - Lifecycle

    override func loadView() {
        view = VinylPageView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        embedDetailsController()
        embedBarController()
        setUpBarControlTap()
        detailsView.headerView.buyButton.addTarget(self, action: #selector(onBuyTap), for: .touchUpInside)
    }

    // MARK: - Status bar

    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: - Private

    private let barControllerFactory: () -> ShoppingBarControlling
    private let detailsControllerFactory: () -> UIViewController
    private let environment: Environment

    private func embedDetailsController() {
        embed(childViewController: detailsController, inside: pageView.detailsContainerView)
    }

    private func embedBarController() {
        embed(childViewController: barController, inside: pageView.barContainerView)
    }

    private func setUpBarControlTap() {
        barController.barControl.addTarget(self, action: #selector(onBarControlTap), for: .touchUpInside)
    }

    @objc private func onBarControlTap(_: UIControl) {
        environment.presentation.present(context: .shoppingBox)
    }

    private var detailsView: VinylDetailsView! {
        return detailsController.view as? VinylDetailsView
    }

    private var barView: ShoppingBarView! {
        return barController.view as? ShoppingBarView
    }

    @objc private func onBuyTap(_ button: UIButton) {
        guard let boxView = self.barView.checkoutBoxView.snapshotView(afterScreenUpdates: true),
              let boxBackView = self.barView.checkoutBoxBackView.snapshotView(afterScreenUpdates: true),
              let coverView = self.detailsView.headerView.coverImageView.snapshotView(afterScreenUpdates: true) else {
            return
        }

        detailsView.headerView.buyButton.isEnabled = false

        boxView.frame = self.view.convert(self.barView.checkoutBoxView.frame, from: self.barView.frameControl)
        boxBackView.frame = self.view.convert(self.barView.checkoutBoxBackView.frame, from: self.barView.frameControl)
        coverView.frame = self.view.convert(self.detailsView.headerView.coverImageView.frame, from: self.detailsView.headerView)
        [boxBackView, coverView, boxView].forEach(view.addSubview)

        self.barView.checkoutBoxView.alpha = 0.0
        self.detailsView.headerView.coverImageView.alpha = 0.0
        self.barView.checkoutBoxBackView.alpha = 0.0

        let xCover = self.detailsView.headerView.center.x - self.detailsView.headerView.coverImageView.center.x

        UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.01) {
                self.barView.albumCoverView.alpha = 0.0
            }

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.1) {
                let viewsToHide: [UIView] = [
                    self.barView.titleLabel,
                    self.barView.albumCoverView,
                    self.barView.albumCountLabel,
                    self.barView.totalLabel,
                ]

                viewsToHide.forEach { $0.alpha = 0.0 }

                let width = boxView.frame.width * 3.0
                let height = boxView.frame.height * 3.0

                boxView.frame = CGRect(
                    x: self.barView.frameControl.center.x - width * 0.5,
                    y: boxView.center.y - height * 0.5,
                    width: width,
                    height: height
                )

                let backWidth = boxBackView.frame.width * 3.0
                let backHeight = boxBackView.frame.height * 3.0

                boxBackView.frame = CGRect(x: self.barView.frameControl.center.x - backWidth * 0.5, y: boxView.frame.maxY - backHeight, width: backWidth, height: backHeight)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.1) {
                let x = self.detailsView.headerView.vinylView.center.x - self.detailsView.headerView.coverImageView.center.x

                translated(x: -x)(self.detailsView.headerView.vinylView)
                self.detailsView.headerView.vinylView.alpha = 0.0
            }

            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.2) {
                translated(x: xCover)(coverView)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.4) {
                let barViewCenter = self.view.convert(self.barView.frameControl.center, from: self.barView)

                coverView.transform = .identity
                coverView.center = CGPoint(x: boxView.center.x, y: boxView.center.y - 12)

                let width = 3 * self.barView.albumCoverView.frame.size.width
                let height = 3 * self.barView.albumCoverView.frame.size.height
                let y = barViewCenter.y - (boxView.frame.size.height * 1.5) + 21

                coverView.frame = CGRect(x: barViewCenter.x - width * 0.5, y: y, width: width, height: height)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.2) {
                boxView.frame = self.view.convert(self.barView.checkoutBoxView.frame, from: self.barView.frameControl)
                coverView.frame = self.view.convert(self.barView.albumCoverView.frame, from: self.barView.frameControl)
                boxBackView.frame = self.view.convert(self.barView.checkoutBoxBackView.frame, from: self.barView.frameControl)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.001) {
                self.detailsView.headerView.vinylView.transform = .identity
                coverView.alpha = 0.0
                self.barView.albumCoverView.alpha = 1.0
                self.barView.checkoutBoxBackView.alpha = 1.0
                boxBackView.alpha = 0.0
            }

            UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.1) {
                self.detailsView.headerView.coverImageView.alpha = 1.0
                self.detailsView.headerView.vinylView.alpha = 1.0

                [self.barView.titleLabel, self.barView.albumCountLabel, self.barView.totalLabel]
                    .forEach { $0.alpha = 1.0 }
            }
        }, completion: { finished in
            if finished {
                self.barView.checkoutBoxView.alpha = 1.0
                [boxView, coverView, boxBackView].forEach { $0.removeFromSuperview() }
                self.detailsView.headerView.buyButton.isEnabled = true
            }
        })
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}

func translated(x: CGFloat = 0.0, y: CGFloat = 0.0) -> (UIView) -> Void {
    return { view in
        view.transform = view.transform.translatedBy(x: x, y: y)
    }
}

func scaled(x: CGFloat = 1.0, y: CGFloat = 1.0) -> (UIView) -> Void {
    return { view in
        view.transform = view.transform.scaledBy(x: x, y: y)
    }
}

func scaled(_ scale: CGFloat = 1.0) -> (UIView) -> Void {
    return scaled(x: scale, y: scale)
}
