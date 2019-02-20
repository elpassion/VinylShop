import BonMot
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

        setUpTabs()
        selectInitialTab()
        setUpTabBarAppearance()
    }

    // MARK: - Private

    private let environment: Environment
    private let tabsFactory: (Environment) -> [Tab]
    private lazy var tabs: [Tab] = tabsFactory(environment)

    private func setUpTabs() {
        viewControllers = tabs.map { $0.tabViewController }
    }

    private func selectInitialTab() {
        if let selectedIndex = tabs.initialSelectedIndex {
            self.selectedIndex = selectedIndex
        }
    }

    private func setUpTabBarAppearance() {
        tabBar.isTranslucent = false
        tabBar.tintColor = Color.blue2FC5D8.ui()
        tabBar.unselectedItemTintColor = Color.black000000.ui(alpha: 0.5)
    }

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
        tabViewController.tabBarItem.setTitleTextAttributes(StringStyle.tabTitleStyle.attributes, for: .normal)
        tabViewController.tabBarItem.isEnabled = isEnabled

        return tabViewController
    }

    private var image: UIImage? {
        return UIImage(named: "tab_\(imageFile)")?.withRenderingMode(.alwaysOriginal)
    }

    private var selectedImage: UIImage? {
        return UIImage(named: "tab_\(imageFile)_selected")?.withRenderingMode(.alwaysOriginal)
    }

    private var imageFile: String {
        return title.lowercased()
    }

}
