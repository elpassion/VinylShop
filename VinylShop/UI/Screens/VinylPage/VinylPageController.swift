import UIKit

class VinylPageController: UIViewController {

    init(barControllerFactory: @escaping () -> UIViewController) {
        self.barControllerFactory = barControllerFactory

        super.init(nibName: nil, bundle: nil)
    }

    var pageView: VinylPageView! {
        return view as? VinylPageView
    }

    override func loadView() {
        view = VinylPageView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        embed(childViewController: barController, inside: pageView.barContainerView)
    }

    // MARK: - Private

    private let barControllerFactory: () -> UIViewController
    private lazy var barController: UIViewController = barControllerFactory()

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}
