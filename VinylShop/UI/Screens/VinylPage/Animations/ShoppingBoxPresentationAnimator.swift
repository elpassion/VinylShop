import UIKit

struct Globals {
    static let animationSpeed: Float = 1.0
}

class ShoppingBoxPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: - UIViewControllerAnimatedTransitioning

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // FIXME: Spike solution
        let pageController = transitionContext.viewController(forKey: .from)
            .flatMap { $0 as? UINavigationController }
            .flatMap { $0.viewControllers.last as? VinylPageController }

        guard let presenting = pageController,
              let presented = transitionContext.viewController(forKey: .to) as? ShoppingBoxController,
              let barSnapshot = presenting.barController.view.snapshotView(afterScreenUpdates: true) else {
            return
        }

        presenting.barController.view.isHidden = true
        barSnapshot.frame = presenting.pageView.barContainerView.frame

        let containerView = transitionContext.containerView
        presented.view.frame = containerView.bounds
        containerView.addSubview(presented.view)
        containerView.addSubview(barSnapshot)

        let boxView: ShoppingBoxView = presented.boxView
        boxView.setNeedsLayout()
        boxView.layoutIfNeeded()

        let fadedInViews = [
            boxView.dismissIconView,
            boxView.titleLabel,
            boxView.topSeparatorView,
            boxView.itemsView,
            boxView.bottomSeparatorView,
            boxView.footerView
        ]

        let fadeInDelays = [0.1, 0.25, 0.30, 0.35, 0.40, 0.45]
        let snapshotViews: [UIView] = fadedInViews.compactMap { view in
            let snapshotView = view.snapshotView(afterScreenUpdates: true)
            snapshotView?.frame = view.frame
            return snapshotView
        }

        guard snapshotViews.count == fadedInViews.count else {
            return
        }

        fadedInViews.forEach { $0.layer.opacity = 0.0 }
        snapshotViews.forEach { view in
            view.layer.opacity = 0.0
            view.frame = boxView.convert(view.frame, from: boxView.boxView)
            containerView.addSubview(view)
        }

        let duration = transitionDuration(using: transitionContext)
        let beginTime = CACurrentMediaTime()

        backgroundAnimator = DimmedBackgroundAnimator(
            view: presented.boxView.dimmedBackgroundView,
            beginTime: beginTime,
            duration: duration
        )

        backgroundAnimator?.animate()

        shoppingBarAnimator = ShoppingBarAnimator(view: barSnapshot, beginTime: beginTime, duration: duration)
        shoppingBarAnimator?.animate()

        fadeInAnimators = (0..<fadedInViews.count).map { index in
            let delayedBeginTime = beginTime + fadeInDelays[index] * duration
            return FadeInAnimator(view: snapshotViews[index], beginTime: delayedBeginTime, duration: duration)
        }

        fadeInAnimators.forEach { $0.animate() }

        let onCompleted: () -> Void = {
            presenting.barController.view.isHidden = false
            snapshotViews.forEach { $0.removeFromSuperview() }
            fadedInViews.forEach { $0.layer.opacity = 1.0 }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        let offset = presenting.pageView.barContainerView.frame.minY - presented.boxView.boxView.frame.minY

        shoppingBoxAnimator = ShoppingBoxAnimator(
            view: presented.boxView.boxView,
            beginTime: beginTime,
            duration: duration,
            offset: offset,
            onCompleted: onCompleted
        )

        shoppingBoxAnimator?.animate()
    }

    // MARK: - Private

    private var backgroundAnimator: DimmedBackgroundAnimator?
    private var shoppingBarAnimator: ShoppingBarAnimator?
    private var dismissAnimator: FadeInAnimator?
    private var shoppingBoxAnimator: ShoppingBoxAnimator?
    private var fadeInAnimators = [FadeInAnimator]()

}

class DimmedBackgroundAnimator: NSObject, CAAnimationDelegate {

    init(view: UIView, beginTime: CFTimeInterval, duration: TimeInterval) {
        self.view = view
        self.beginTime = beginTime
        self.duration = duration
    }

    // MARK: - Public API

    func animate() {
        view.layer.opacity = 0.0

        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = duration
        animation.isRemovedOnCompletion = true
        animation.beginTime = beginTime
        animation.delegate = self

        view.layer.add(animation, forKey: nil)
    }

    // MARK: - CAAnimationDelegate

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            view.layer.opacity = 1.0
        }
    }

    // MARK: - Private

    private let view: UIView
    private let beginTime: CFTimeInterval
    private let duration: TimeInterval
}

class ShoppingBarAnimator: NSObject, CAAnimationDelegate {

    init(view: UIView, beginTime: CFTimeInterval, duration: TimeInterval) {
        self.view = view
        self.beginTime = beginTime
        self.duration = duration
    }

    // MARK: - Public API

    func animate() {
        let positionAnimation = CABasicAnimation(keyPath: "position.y")
        positionAnimation.byValue = 50

        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = 0.0

        let animation = CAAnimationGroup()
        animation.animations = [positionAnimation, opacityAnimation]
        animation.beginTime = beginTime
        animation.delegate = self
        animation.duration = duration * 0.3
        animation.isRemovedOnCompletion = true
        animation.speed = Globals.animationSpeed
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        view.layer.add(animation, forKey: nil)
    }

    // MARK: - CAAnimationDelegate

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            view.removeFromSuperview()
        }
    }

    // MARK: - Private

    private let view: UIView
    private let beginTime: CFTimeInterval
    private let duration: TimeInterval

}

class FadeInAnimator: NSObject, CAAnimationDelegate {

    init(view: UIView, beginTime: CFTimeInterval, duration: TimeInterval) {
        self.view = view
        self.beginTime = beginTime
        self.duration = duration
    }
    
    // MARK: - Public API

    func animate() {
        let positionAnimation = CABasicAnimation(keyPath: "position.y")
        positionAnimation.fromValue = view.frame.maxY + 20

        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0.0
        opacityAnimation.toValue = 1.0

        let animation = CAAnimationGroup()
        animation.beginTime = beginTime
        animation.duration = duration * 0.3
        animation.animations = [positionAnimation, opacityAnimation]
        animation.isRemovedOnCompletion = true
        animation.speed = Globals.animationSpeed
        animation.delegate = self
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        view.layer.add(animation, forKey: nil)
    }

    // MARK: - CAAnimationDelegate

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            view.layer.opacity = 1.0
        }
    }

    // MARK: - Private

    private let view: UIView
    private let beginTime: CFTimeInterval
    private let duration: TimeInterval

}

class ShoppingBoxAnimator: NSObject, CAAnimationDelegate {

    init(view: UIView,
         beginTime: CFTimeInterval,
         duration: TimeInterval,
         offset: CGFloat,
         onCompleted: @escaping () -> Void) {
        self.view = view
        self.beginTime = beginTime
        self.duration = duration
        self.offset = offset
        self.onCompleted = onCompleted
    }

    // MARK: - Public API

    func animate() {
        view.layer.position.y += offset

        let animation = CASpringAnimation(keyPath: "position.y")
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.byValue = -offset
        animation.duration = duration
        animation.isRemovedOnCompletion = true
        animation.stiffness = 200.0
        animation.mass = 1
        animation.initialVelocity = 0
        animation.damping = 18
        animation.beginTime = beginTime
        animation.delegate = self
        animation.speed = Globals.animationSpeed

        view.layer.add(animation, forKey: nil)
    }

    // MARK: - CAAnimationDelegate

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            view.layer.position.y -= offset
            onCompleted()
        }
    }

    // MARK: - Private

    private let view: UIView
    private let beginTime: CFTimeInterval
    private let duration: TimeInterval
    private let offset: CGFloat
    private let onCompleted: () -> Void

}
