import UIKit

func makeController(for route: Route) -> UIViewController {
    switch route {
    case .vinylPage:
        return VinylPageController()
    }
}
