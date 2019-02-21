import UIKit

func makeAnimationController(for route: Route) -> UIViewControllerAnimatedTransitioning? {
    switch route {
    case let .vinylPage(vinylID):
        return VinylPagePushAnimator(vinylID: vinylID)
    }
}
