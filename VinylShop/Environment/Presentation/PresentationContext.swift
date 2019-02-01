import UIKit

struct PresentationContext {
    let factory: () -> UIViewController
    let animated: Bool
    let presentationStyle: UIModalPresentationStyle
    let transitionStyle: UIModalTransitionStyle
}
