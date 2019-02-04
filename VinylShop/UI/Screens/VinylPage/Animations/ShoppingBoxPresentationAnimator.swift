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

        presented.boxView.setNeedsLayout()
        presented.boxView.layoutIfNeeded()

        guard let dismissIconView = presented.boxView.dismissIconView.snapshotView(afterScreenUpdates: true) else {
            return
        }

        dismissIconView.layer.opacity = 0.0
        dismissIconView.frame = presented.boxView.convert(
            presented.boxView.dismissIconView.frame,
            from: presented.boxView.boxView
        )
        containerView.addSubview(dismissIconView)

        presented.boxView.boxView.subviews.forEach { $0.layer.opacity = 0.0 }

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

        dismissAnimator = DismissIconAnimator(
            view: dismissIconView,
            beginTime: beginTime,
            duration: duration
        )

        dismissAnimator?.animate()

        let onCompleted: () -> Void = {
            presenting.barController.view.isHidden = false
            presented.boxView.dismissIconView.layer.opacity = 1.0
            dismissIconView.removeFromSuperview()
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
    private var dismissAnimator: DismissIconAnimator?
    private var shoppingBoxAnimator: ShoppingBoxAnimator?

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

class DismissIconAnimator: NSObject, CAAnimationDelegate {

    init(view: UIView, beginTime: CFTimeInterval, duration: TimeInterval) {
        self.view = view
        self.beginTime = beginTime
        self.duration = duration
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
        animation.beginTime = beginTime + 0.125 * duration
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
        }
    }

    // MARK: - Private

    private let view: UIView
    private let beginTime: CFTimeInterval
    private let duration: TimeInterval

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
