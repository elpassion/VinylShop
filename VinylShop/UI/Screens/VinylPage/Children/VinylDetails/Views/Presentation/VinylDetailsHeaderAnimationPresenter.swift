import UIKit

class VinylDetailsHeaderAnimationPresenter {

    func present(animation: VinylDetailsHeaderAnimationProgress, in view: VinylDetailsView) {
        updateHeight(ofHeaderIn: view, to: animation.headerHeight)
        positionElements(in: view.headerView, to: animation)
    }

    // MARK: - Private

    private func updateHeight(ofHeaderIn view: VinylDetailsView, to height: CGFloat) {
        view.headerHeightConstraint?.constant = height
    }

    private func positionElements(in view: VinylDetailsHeaderView, to animation: VinylDetailsHeaderAnimationProgress) {
        view.coverSizeConstraint?.first.constant = animation.coverImageSize.width
        view.coverSizeConstraint?.second.constant = animation.coverImageSize.height
        view.vinylCenterOffsetConstraint?.constant = animation.vinylCenterOffset
        view.largeTitleView.alpha = animation.largeTitleAlpha
        view.smallTitleView.alpha = animation.smallTitleAlpha
        view.smallBottomAnchorConstraint?.isActive = !animation.largeTitleVisible
        view.largeBottomAnchorConstraint?.isActive = animation.largeTitleVisible
    }

}

private extension VinylDetailsHeaderAnimationProgress {

    var largeTitleVisible: Bool {
        return largeTitleAlpha > 0.0
    }

}
