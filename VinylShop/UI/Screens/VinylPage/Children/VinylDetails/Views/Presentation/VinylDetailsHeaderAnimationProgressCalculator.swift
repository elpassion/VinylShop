import UIKit

class VinylDetailsHeaderAnimationProgressCalculator {

    func progress(for height: VinylDetailsHeaderHeight,
                  in view: VinylDetailsView) -> VinylDetailsHeaderAnimationProgress {
        let headerHeight = height.scale * view.headerPlaceholderView.frame.size.height
        let coverImageSize = height.scrollProgress.size(
            between: VinylDetailsHeaderView.minCoverSize,
            and: VinylDetailsHeaderView.maxCoverSize
        )
        let vinylCenterOffset = coverImageSize.width * (45.0 / VinylDetailsHeaderView.maxCoverSize.width)
        let largeTitleAlpha = scaledPercent(from: 0.9, to: 1.0, progress: height.scrollProgress)
        let smallTitleAlpha = 1 - scaledPercent(from: 0.0, to: 0.1, progress: height.scrollProgress)

        return VinylDetailsHeaderAnimationProgress(
            headerHeight: headerHeight,
            coverImageSize: coverImageSize,
            vinylCenterOffset: vinylCenterOffset,
            largeTitleAlpha: largeTitleAlpha,
            smallTitleAlpha: smallTitleAlpha
        )
    }

    // MARK: - Private

    private func scaledPercent(from fromValue: CGFloat, to toValue: CGFloat, progress: CGFloat) -> CGFloat {
        guard fromValue != toValue else { fatalError() }

        let range = toValue - fromValue
        let scaledProgress = (progress - fromValue) / range
        return min(max(scaledProgress, 0.0), 1.0)
    }

}

private extension CGFloat {

    func size(between minSize: CGSize, and maxSize: CGSize) -> CGSize {
        let width = minSize.width + (maxSize.width - minSize.width) * self
        let height = minSize.height + (maxSize.height - minSize.height) * self
        return CGSize(width: width, height: height)
    }

}
