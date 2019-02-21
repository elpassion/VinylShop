import UIKit

func makeAnimationController(for route: Route) -> UIViewControllerAnimatedTransitioning? {
    switch route {
    case .vinylPage:
        return VinylPagePushAnimator()
    }
}
