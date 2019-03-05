import UIKit

struct ShoppingBoxDismissAnimationContext {
    let shoppingController: ShoppingBoxController
    let pageController: VinylPageController
    let shoppingBarView: ShoppingBarView
    let fadedOutViews: [UIView]
    lazy var fadedOutSnapshotViews: [UIView] = fadedOutViews.compactMap { $0.snapshotView(afterScreenUpdates: true) }

    init?(transitionContext: UIViewControllerContextTransitioning) {
        let pageController = transitionContext.viewController(forKey: .to)
            .flatMap { $0 as? UINavigationController }
            .flatMap { $0.viewControllers.last as? VinylPageController }

        let shoppingBoxController = transitionContext.viewController(forKey: .from) as? ShoppingBoxController
        let shoppingBarSnapshotView = pageController?.barController.view.snapshotView(afterScreenUpdates: true)
        let fadedOutViews = shoppingBoxController.map { viewsToFade(in: $0.boxView) }

        guard let unwrappedShoppingBoxController = shoppingBoxController,
              let unwrappedPageController = pageController,
              let unwrappedShoppingBarView = unwrappedPageController.barController.view as? ShoppingBarView,
              let unwrappedFadedOutViews = fadedOutViews else {
            return nil
        }

        self.pageController = unwrappedPageController
        self.shoppingController = unwrappedShoppingBoxController
        self.shoppingBarView = unwrappedShoppingBarView
        self.fadedOutViews = unwrappedFadedOutViews
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
