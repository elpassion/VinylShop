import UIKit

struct Tab {
    let controller: UIViewController
    let title: String
    let isEnabled: Bool
    let initialState: InitialTabSelection
}

enum InitialTabSelection: String {
    case selected
    case unselected
}
