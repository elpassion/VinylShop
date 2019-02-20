@testable import VinylShop
import Nimble
import Quick
import UIKit

class EnvironmentSpec: QuickSpec {

    override func spec() {
        describe("Environment") {
            var sut: Environment!

            beforeEach {
                sut = Environment()
            }

            afterEach {
                sut = nil
            }

            describe("shared instance") {
                it("should always return the same instance") {
                    expect(Environment.shared) === Environment.shared
                }
            }

            describe("navigation controller") {
                it("should have correct root view controller set") {
                    expect(sut.navigationController.viewControllers).to(haveCount(1))
                    expect(sut.navigationController.viewControllers.first).to(beAnInstanceOf(ShopController.self))
                }

                it("should have navigation bar hidden") {
                    expect(sut.navigationController.navigationBar.isHidden) == true
                }
            }

            describe("presentation") {
                var rootViewController: UIViewController?
                var stubbedCurrentController: UIViewController!

                beforeEach {
                    rootViewController = UIApplication.shared.keyWindow?.rootViewController
                    stubbedCurrentController = UIViewController()

                    sut.navigationController.setViewControllers([stubbedCurrentController], animated: false)
                    UIApplication.shared.keyWindow?.rootViewController = sut.navigationController
                }

                afterEach {
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    rootViewController = nil
                    stubbedCurrentController = nil
                }

                describe("present") {
                    var presentedController: UIViewController!
                    var presentationContext: PresentationContext!
                    var presentAnimator: UIViewControllerAnimatedTransitioning!
                    var dismissAnimator: UIViewControllerAnimatedTransitioning!

                    beforeEach {
                        presentedController = UIViewController()
                        presentAnimator = AnimatorStub()
                        dismissAnimator = AnimatorStub()

                        presentationContext = PresentationContext(
                            id: .shoppingBox,
                            factory: { presentedController },
                            animated: false,
                            presentationStyle: .custom,
                            transitionStyle: .flipHorizontal,
                            presentAnimator: presentAnimator,
                            dismissAnimator: dismissAnimator
                        )

                        sut.presentation.present(context: presentationContext)
                    }

                    afterEach {
                        presentAnimator = nil
                        dismissAnimator = nil
                        presentationContext = nil
                        presentedController = nil
                    }

                    it("should present a controller on the active controller") {
                        expect(stubbedCurrentController.presentedViewController) === presentedController
                    }

                    describe("dismiss") {
                        beforeEach {
                            sut.presentation.dismiss(presentedController, animated: false)
                        }

                        it("should dismiss a controller") {
                            expect(stubbedCurrentController.presentedViewController).toEventually(beNil())
                        }
                    }

                    describe("presented controller") {
                        it("should have presentation style set") {
                            expect(presentedController.modalPresentationStyle) == UIModalPresentationStyle.custom
                        }

                        it("should have transition style set") {
                            expect(presentedController.modalTransitionStyle) == UIModalTransitionStyle.flipHorizontal
                        }

                        describe("transition delegate") {
                            it("should return dismiss animator") {
                                let receivedDismissAnimator = presentedController.transitioningDelegate?.animationController?(
                                    forDismissed: UIViewController()
                                )

                                expect(receivedDismissAnimator) === dismissAnimator
                            }

                            it("should return present animator") {
                                let receivedPresentAnimator = presentedController.transitioningDelegate?.animationController?(
                                    forPresented: UIViewController(),
                                    presenting: UIViewController(),
                                    source: UIViewController()
                                )

                                expect(receivedPresentAnimator) === presentAnimator
                            }
                        }
                    }
                }

                describe("present with deallocated context") {
                    var presentedController: PresentedControllerStub!
                    var presentAnimator: AnimatorStub!
                    var dismissAnimator: AnimatorStub!

                    beforeEach {
                        presentedController = PresentedControllerStub()
                        presentAnimator = AnimatorStub()
                        dismissAnimator = AnimatorStub()

                        let presentationContext = PresentationContext(
                            id: .shoppingBox,
                            factory: { presentedController },
                            animated: false,
                            presentationStyle: .custom,
                            transitionStyle: .flipHorizontal,
                            presentAnimator: presentAnimator,
                            dismissAnimator: dismissAnimator
                        )

                        sut.presentation.present(context: presentationContext)
                    }

                    afterEach {
                        presentedController = nil
                        presentAnimator = nil
                        dismissAnimator = nil
                    }

                    describe("presented controller") {
                        it("should have transitioning delegate set") {
                            expect(presentedController.transitioningDelegate).toNot(beNil())
                        }

                        it("should have present animator set") {
                            let animator = presentedController.transitioningDelegate?.animationController?(
                                forPresented: UIViewController(),
                                presenting: UIViewController(),
                                source: UIViewController()
                            )

                            expect(animator) === presentAnimator
                        }

                        it("should have dismiss animator set") {
                            let animator = presentedController.transitioningDelegate?.animationController?(
                                forDismissed: UIViewController()
                            )

                            expect(animator) === dismissAnimator
                        }

                        describe("dismiss") {
                            beforeEach {
                                sut.presentation.dismiss(presentedController, animated: false)
                            }

                            it("should NOT have transitioning delegate any more") {
                                expect(presentedController.transitioningDelegate).toEventually(beNil())
                            }
                        }
                    }
                }
            }
        }
    }

}

class AnimatorStub: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {}

}

class PresentedControllerStub: UIViewController {

    override func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        completion?()
    }

}
