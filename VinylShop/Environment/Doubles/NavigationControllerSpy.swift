import UIKit

class NavigationControllerSpy: UINavigationController {

    private(set) var invokedSetViewControllers: [(viewControllers: [UIViewController], animated: Bool?)] = []

    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        capturedViewControllers = viewControllers
        invokedSetViewControllers.append((viewControllers: viewControllers, animated: animated))
    }

    override var viewControllers: [UIViewController] {
        get { return capturedViewControllers }
        set { capturedViewControllers = newValue }
    }

    // MARK: - Private

    private var capturedViewControllers: [UIViewController] = []

}
