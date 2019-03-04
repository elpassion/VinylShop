import UIKit

struct VinylPagePopAnimatorContext {
    let pageController: VinylPageController
    let shopController: ShopController
    let vinylCell: VinylCollectionCell
    let coverSnapshotView: UIView

    init?(vinylID: Int, transitionContext: UIViewControllerContextTransitioning) {
        guard let pageController = transitionContext.viewController(forKey: .from) as? VinylPageController,
              let shopController = transitionContext.viewController(forKey: .to) as? ShopController,
              let vinylCell = findVinylCell(forVinylID: vinylID, in: shopController),
              let coverSnapshotView = pageController.coverImageView.snapshotView(afterScreenUpdates: true) else {
            return nil
        }

        self.pageController = pageController
        self.shopController = shopController
        self.vinylCell = vinylCell
        self.coverSnapshotView = coverSnapshotView
    }

}

private extension VinylPageController {

    var coverImageView: UIImageView {
        return detailsController.detailsView.headerView.coverImageView
    }

}
