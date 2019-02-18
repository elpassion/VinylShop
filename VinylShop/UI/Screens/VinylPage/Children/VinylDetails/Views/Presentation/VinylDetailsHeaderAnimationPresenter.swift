import UIKit

class VinylDetailsHeaderAnimationPresenter {

    func present(animation: VinylDetailsHeaderAnimationProgress, in view: VinylDetailsView) {
        showHeader(in: view)
        updateHeight(ofHeaderIn: view, to: animation.headerHeight)
        positionElements(in: view.headerView, to: animation)
    }
    
    // MARK: - Private

    private func showHeader(in view: VinylDetailsView) {
        view.headerView.alpha = 1.0
        view.headerPlaceholderView.alpha = 0.0
    }

    private func updateHeight(ofHeaderIn view: VinylDetailsView, to height: CGFloat) {
        view.headerHeightConstraint?.constant = height
    }

    private func positionElements(in view: VinylDetailsHeaderView, to animation: VinylDetailsHeaderAnimationProgress) {
        view.coverSizeConstraint?.first.constant = animation.coverImageSize.width
        view.coverSizeConstraint?.second.constant = animation.coverImageSize.height
        view.vinylCenterOffsetConstraint?.constant = animation.vinylCenterOffset
        view.largeTitleView.alpha = animation.largeTitleAlpha
        view.smallTitleView.alpha = animation.smallTitleAlpha
    }

}
