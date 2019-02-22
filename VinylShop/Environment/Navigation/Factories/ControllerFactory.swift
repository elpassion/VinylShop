import UIKit

func makeController(for route: Route) -> UIViewController {
    switch route {
    case let .vinylPage(vinylID):
        return VinylPageController(vinylID: vinylID)
    }
}
