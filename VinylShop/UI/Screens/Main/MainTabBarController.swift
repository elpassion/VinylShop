import UIKit

class MainTabBarController: UITabBarController {

    init(environment: Environment = Environment.shared,
         tabsFactory: @escaping (Environment) -> [Tab] = makeMainTabs) {
        self.environment = environment
        self.tabsFactory = tabsFactory
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = tabs.map { $0.tabViewController }
        tabBar.isTranslucent = false

        if let selectedIndex = tabs.initialSelectedIndex {
            self.selectedIndex = selectedIndex
        }
    }

    // MARK: - Private

    private let environment: Environment
    private let tabsFactory: (Environment) -> [Tab]
    private lazy var tabs: [Tab] = tabsFactory(environment)

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}

private extension Array where Element == Tab {

    var initialSelectedIndex: Int? {
        return enumerated()
            .filter { $0.1.initialState == .selected }
            .map { $0.0 }
            .first
    }

}

private extension Tab {

    var tabViewController: UIViewController {
        let tabViewController = controller
        tabViewController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        tabViewController.tabBarItem.isEnabled = isEnabled

        return tabViewController
    }

    private var image: UIImage? {
        return UIImage(named: "tab_\(imageFile)")
    }

    private var selectedImage: UIImage? {
        return UIImage(named: "tab_\(imageFile)_selected")
    }

    private var imageFile: String {
        return title.lowercased()
    }

}
