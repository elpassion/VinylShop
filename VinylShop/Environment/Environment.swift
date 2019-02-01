import UIKit

class Environment {
    static let shared = Environment()

    let navigationController = UINavigationController()
    lazy var presentation = PresentationEnvironment(navigationController: navigationController)
}


