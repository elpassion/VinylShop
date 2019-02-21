import UIKit

func makeGoToAnimationController(for route: Route) -> UIViewControllerAnimatedTransitioning? {
    switch route {
    case let .vinylPage(vinylID):
        return VinylPagePushAnimator(vinylID: vinylID)
    }
}
