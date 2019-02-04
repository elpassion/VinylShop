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

        let fadeInDelays = [0.125, 0.25, 0.4, 0.55, 0.71, 0.82]
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
            let delay = fadeInDelays[index] * duration

            return FadeInAnimator(view: snapshotViews[index], beginTime: beginTime + delay, duration: duration) {
                snapshotViews[index].removeFromSuperview()
                fadedInViews[index].layer.opacity = 1.0
            }
        }

        fadeInAnimators.forEach { $0.animate() }

        let onCompleted: () -> Void = {
            presenting.barController.view.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        shoppingBoxAnimator = ShoppingBoxAnimator(
            view: presented.boxView.boxView,
            beginTime: beginTime,
            duration: duration,
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
        animation.duration = duration * 0.5
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
        animation.duration = duration * 0.375
        animation.isRemovedOnCompletion = true
        animation.speed = Globals.animationSpeed

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

    init(view: UIView, beginTime: CFTimeInterval, duration: TimeInterval, completion: (() -> Void)? = nil) {
        self.view = view
        self.beginTime = beginTime
        self.duration = duration
        self.completion = completion
    }
    
    // MARK: - Public API

    func animate() {
        let positionAnimation = CABasicAnimation(keyPath: "position.y")
        positionAnimation.fromValue = view.frame.minY + 50
        positionAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0.0
        opacityAnimation.toValue = 1.0
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let animation = CAAnimationGroup()
        animation.beginTime = beginTime
        animation.duration = duration * 0.375
        animation.animations = [positionAnimation, opacityAnimation]
        animation.isRemovedOnCompletion = true
        animation.speed = Globals.animationSpeed
        animation.delegate = self

        view.layer.add(animation, forKey: nil)
    }

    // MARK: - CAAnimationDelegate

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            view.layer.opacity = 1.0
            completion?()
        }
    }

    // MARK: - Private

    private let view: UIView
    private let beginTime: CFTimeInterval
    private let duration: TimeInterval
    private let completion: (() -> Void)?

}

class ShoppingBoxAnimator: NSObject, CAAnimationDelegate {

    init(view: UIView, beginTime: CFTimeInterval, duration: TimeInterval, onCompleted: @escaping () -> Void) {
        self.view = view
        self.beginTime = beginTime
        self.duration = duration
        self.onCompleted = onCompleted
    }

    // MARK: - Public API

    func animate() {
        view.layer.position.y += view.layer.frame.height

        let animation = CASpringAnimation(keyPath: "position.y")
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.byValue = -view.layer.frame.height
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
            view.layer.position.y -= view.layer.frame.height
            onCompleted()
        }
    }

    // MARK: - Private

    private let view: UIView
    private let beginTime: CFTimeInterval
    private let duration: TimeInterval
    private let onCompleted: () -> Void

}
