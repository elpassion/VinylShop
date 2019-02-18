import UIKit

class VinylDetailsHeaderAnimationProgressCalculator {

    func progress(for position: VinylDetailsScrollPosition,
                  in view: VinylDetailsView) -> VinylDetailsHeaderAnimationProgress {
        let yCurrentBottom = position.yBottom - position.yContentOffset
        let minimalHeight = position.topSafeInset + collapsedHeaderHeight
        let currentHeight = min(max(yCurrentBottom, minimalHeight), position.height)
        let scale = currentHeight / position.height
        let progress = (currentHeight - minimalHeight) / (position.height - minimalHeight)
        let coverImageSize = self.coverImageSize(progress: progress)

        return VinylDetailsHeaderAnimationProgress(
            headerHeight: scale * position.height,
            coverImageSize: coverImageSize,
            vinylCenterOffset: coverImageSize.width * vinylCenterOffsetScale,
            largeTitleAlpha: scaled(progress: progress, inRangeFrom: 0.9, to: 1.0),
            smallTitleAlpha: 1 - scaled(progress: progress, inRangeFrom: 0.0, to: 0.1)
        )
    }

    // MARK: - Private

    private let collapsedHeaderHeight: CGFloat = 116

    private func coverImageSize(progress: CGFloat) -> CGSize {
        return size(
            from: VinylDetailsHeaderView.minCoverSize,
            to: VinylDetailsHeaderView.maxCoverSize,
            withScrollProgress: progress
        )
    }

    private var vinylCenterOffsetScale: CGFloat {
        return VinylDetailsHeaderView.maxVinylCenterOffset / VinylDetailsHeaderView.maxCoverSize.width
    }

    private func scaled(progress: CGFloat, inRangeFrom from: CGFloat, to: CGFloat) -> CGFloat {
        let scaledProgress = (progress - from) / (to - from)
        return min(max(scaledProgress, 0.0), 1.0)
    }

    private func size(from: CGSize, to: CGSize, withScrollProgress progress: CGFloat) -> CGSize {
        let width = from.width + (to.width - from.width) * progress
        let height = from.height + (to.height - from.height) * progress
        return CGSize(width: width, height: height)
    }

}
