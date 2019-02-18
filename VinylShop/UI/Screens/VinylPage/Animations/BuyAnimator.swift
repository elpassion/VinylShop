import UIKit

class BuyAnimator {

    func animateBuy(view: UIView,
                    detailsView: VinylDetailsView,
                    barView: ShoppingBarView,
                    completion: @escaping () -> Void) {
        guard let boxBackView = setUp(snapshotOf: barView.checkoutBoxBackView, from: view),
              let coverView = setUp(snapshotOf: detailsView.headerView.coverImageView, from: view),
              let boxView = setUp(snapshotOf: barView.checkoutBoxView, from: view) else {
            return
        }

        UIView.animateKeyframes(withDuration: 1.1, delay: 0.0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.001) {
                barView.albumCoverView.alpha = 0.0
                barView.frameControl.alpha = 1.0
            }

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3 / 1.1) {
                [barView.titleLabel, barView.albumCoverView, barView.albumCountLabel, barView.totalLabel]
                    .forEach { $0.alpha = 0.0 }

                self.scaleUpBoxView(boxView, centerX: barView.frameControl.center.x)
                self.scaleUpBackBoxView(
                    boxBackView,
                    centerX: barView.frameControl.center.x,
                    bottomY: boxView.frame.maxY
                )
            }

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.1 / 1.1) {
                self.hideVinylView(detailsView.headerView.vinylView, coverView: detailsView.headerView.coverImageView)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3 / 1.1) {
                self.centerCoverView(coverView, headerView: detailsView.headerView)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.3 / 1.1, relativeDuration: 0.35 / 1.1) {
                self.dropCoverView(coverView, view: view, barView: barView, boxView: boxView)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.65 / 1.1, relativeDuration: 0.3 / 1.1) {
                self.placeInShoppingBar(subview: boxView, originalView: barView.checkoutBoxView, view: view)
                self.placeInShoppingBar(subview: boxBackView, originalView: barView.checkoutBoxBackView, view: view)
                self.placeInShoppingBar(subview: coverView, originalView: barView.albumCoverView, view: view)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.8 / 1.1, relativeDuration: 0.001) {
                detailsView.headerView.vinylView.transform = .identity
            }

            UIView.addKeyframe(withRelativeStartTime: 0.95 / 1.1, relativeDuration: 0.001) {
                barView.albumCoverView.alpha = 1.0
                coverView.alpha = 0.0
                barView.checkoutBoxBackView.alpha = 1.0
                boxBackView.alpha = 0.0
            }

            UIView.addKeyframe(withRelativeStartTime: 0.8 / 1.1, relativeDuration: 0.3 / 1.1) {
                detailsView.headerView.coverImageView.alpha = 1.0
                detailsView.headerView.vinylView.alpha = 1.0

                [barView.titleLabel, barView.albumCountLabel, barView.totalLabel].forEach { $0.alpha = 1.0 }
            }
        }, completion: { finished in
            if finished {
                barView.checkoutBoxView.alpha = 1.0
                [boxView, coverView, boxBackView].forEach { $0.removeFromSuperview() }
                completion()
            }
        })
    }

    // MARK: - Private

    private func setUp(snapshotOf subview: UIView, from view: UIView) -> UIView? {
        guard let superview = subview.superview,
              let snapshotView = subview.snapshotView(afterScreenUpdates: true) else {
            return nil
        }

        subview.alpha = 0.0
        snapshotView.frame = view.convert(subview.frame, from: superview)
        view.addSubview(snapshotView)

        return snapshotView
    }

    private func scaleUpBoxView(_ boxView: UIView, centerX: CGFloat) {
        let width = boxView.frame.width * 3.0
        let height = boxView.frame.height * 3.0
        boxView.frame = CGRect(
            x: centerX - width * 0.5,
            y: boxView.center.y - height * 0.5,
            width: width,
            height: height
        )
    }

    private func scaleUpBackBoxView(_ boxBackView: UIView, centerX: CGFloat, bottomY: CGFloat) {
        let width = boxBackView.frame.width * 3.0
        let height = boxBackView.frame.height * 3.0
        boxBackView.frame = CGRect(x: centerX - width * 0.5, y: bottomY - height, width: width, height: height)
    }

    private func hideVinylView(_ vinylView: UIView, coverView: UIView) {
        let x = vinylView.center.x - coverView.center.x

        vinylView.transform = vinylView.transform.translatedBy(x: -x, y: 0)
        vinylView.alpha = 0.0
    }

    private func centerCoverView(_ coverView: UIView, headerView: UIView) {
        let x = headerView.center.x - coverView.center.x
        coverView.transform = coverView.transform.translatedBy(x: x, y: 0)
    }

    private func dropCoverView(_ coverView: UIView, view: UIView, barView: ShoppingBarView, boxView: UIView) {
        let width = barView.albumCoverView.frame.size.width * 3.0
        let height = barView.albumCoverView.frame.size.height * 3.0
        let center = view.convert(barView.frameControl.center, from: barView)

        coverView.transform = .identity
        coverView.frame = CGRect(
            x: center.x - width * 0.5,
            y: center.y - boxView.frame.size.height * 1.5 + 21,
            width: width,
            height: height
        )
    }

    private func placeInShoppingBar(subview: UIView, originalView: UIView, view: UIView) {
        if let superview = originalView.superview {
            subview.frame = view.convert(originalView.frame, from: superview)
        }
    }

}
