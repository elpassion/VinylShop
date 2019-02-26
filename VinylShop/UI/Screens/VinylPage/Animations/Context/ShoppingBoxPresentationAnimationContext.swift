import UIKit

struct ShoppingBoxPresentationAnimationContext {
    let pageController: VinylPageController
    let shoppingController: ShoppingBoxController
    let shoppingBarSnapshotView: UIView
    let fadedInViews: [UIView]
    lazy var fadedInSnapshotViews: [UIView] = fadedInViews.compactMap { $0.snapshotView(afterScreenUpdates: true) }

    init?(transitionContext: UIViewControllerContextTransitioning) {
        let pageController = transitionContext.viewController(forKey: .from)
            .flatMap { $0 as? UINavigationController }
            .flatMap { $0.viewControllers.last as? VinylPageController }

        let shoppingBoxController = transitionContext.viewController(forKey: .to) as? ShoppingBoxController
        let shoppingBarSnapshotView = pageController?.barController.view.snapshotView(afterScreenUpdates: true)
        let fadedInViews = shoppingBoxController.map { viewsToFade(in: $0.boxView) }

        guard let unwrappedPageController = pageController,
              let unwrappedShoppingBoxController = shoppingBoxController,
              let unwrappedShoppingBarSnapshotView = shoppingBarSnapshotView,
              let unwrappedFadedInViews = fadedInViews else {
            return nil
        }

        self.pageController = unwrappedPageController
        self.shoppingController = unwrappedShoppingBoxController
        self.shoppingBarSnapshotView = unwrappedShoppingBarSnapshotView
        self.fadedInViews = unwrappedFadedInViews
    }

}

private func viewsToFade(in view: ShoppingBoxView) -> [UIView] {
    return [
        view.dismissIconView,
        view.titleLabel,
        view.topSeparatorView,
        view.itemsView,
        view.bottomSeparatorView,
        view.footerView
    ]
}
