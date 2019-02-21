import UIKit

func makeGoBackAnimationController(for route: Route) -> UIViewControllerAnimatedTransitioning? {
    switch route {
    case let .vinylPage(vinylID):
        return VinylPagePopAnimator(vinylID: vinylID)
    }
}
