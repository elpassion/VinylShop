@testable import VinylShop
import Nimble
import Quick

class ShoppingBoxDismissAnimatorSpec: QuickSpec {

    override func spec() {
        describe("ShoppingBoxDismissAnimator") {
            var sut: ShoppingBoxDismissAnimator!

            beforeEach {
                sut = ShoppingBoxDismissAnimator()
            }

            afterEach {
                sut = nil
            }

            it("should return correct transition duration") {
                expect(sut.transitionDuration(using: nil)) == 0.3
            }

            describe("animate transition") {
                var contextSpy: UIViewControllerContextTransitioningSpy!

                beforeEach {
                    contextSpy = UIViewControllerContextTransitioningSpy()
                }

                afterEach {
                    contextSpy = nil
                }

                describe("with non-matching requirements") {
                    beforeEach {
                        contextSpy.stubbedViewControllerFrom = UIViewController()
                        contextSpy.stubbedViewControllerTo = UIViewController()
                        contextSpy.transitionWasCancelled = false

                        sut.animateTransition(using: contextSpy)
                    }

                    afterEach {
                        cleanUpVerifyTransition(sut: sut)
                    }

                    it("should complete transition") {
                        expect(contextSpy.invokedCompleteWith) == true
                    }
                }

                describe("with matching requirements") {
                    var window: UIWindow!

                    beforeEach {
                        window = UIWindow(frame: .zero)

                        let pageController = VinylPageController(vinylID: Vinyl.testVinyl.id)
                        pageController.barController.barView.isHidden = false

                        let navigationController = UINavigationController(rootViewController: pageController)
                        navigationController.setNavigationBarHidden(true, animated: false)

                        let shoppingBoxController = ShoppingBoxController()

                        contextSpy.containerView.addSubview(navigationController.view)
                        contextSpy.containerView.addSubview(shoppingBoxController.view)

                        setUpTransitioningTest(
                            from: shoppingBoxController,
                            to: navigationController,
                            using: contextSpy,
                            in: window,
                            direction: .backwards
                        )

                        navigationController.spec.prepare.set(viewSize: window.bounds.size)
                        shoppingBoxController.spec.prepare.set(viewSize: window.bounds.size)
                    }

                    afterEach {
                        cleanUpVerifyTransition(sut: sut)
                        window = nil
                    }

                    it("should match snapshot at 0%") {
                        verifyTransition(sut: sut, in: window, fractionComplete: 0, using: contextSpy, named: "shopping_box_dismiss")
                    }

                    it("should match snapshot at 10%") {
                        verifyTransition(sut: sut, in: window, fractionComplete: 0.1, using: contextSpy, named: "shopping_box_dismiss")
                    }

                    it("should match snapshot at 20%") {
                        verifyTransition(sut: sut, in: window, fractionComplete: 0.2, using: contextSpy, named: "shopping_box_dismiss")
                    }

                    it("should match snapshot at 30%") {
                        verifyTransition(sut: sut, in: window, fractionComplete: 0.3, using: contextSpy, named: "shopping_box_dismiss")
                    }

                    it("should match snapshot at 40%") {
                        verifyTransition(sut: sut, in: window, fractionComplete: 0.4, using: contextSpy, named: "shopping_box_dismiss")
                    }

                    it("should match snapshot at 50%") {
                        verifyTransition(sut: sut, in: window, fractionComplete: 0.5, using: contextSpy, named: "shopping_box_dismiss")
                    }

                    it("should match snapshot at 60%") {
                        verifyTransition(sut: sut, in: window, fractionComplete: 0.6, using: contextSpy, named: "shopping_box_dismiss")
                    }

                    it("should match snapshot at 70%") {
                        verifyTransition(sut: sut, in: window, fractionComplete: 0.7, using: contextSpy, named: "shopping_box_dismiss")
                    }

                    it("should match snapshot at 80%") {
                        verifyTransition(sut: sut, in: window, fractionComplete: 0.8, using: contextSpy, named: "shopping_box_dismiss")
                    }

                    it("should match snapshot at 90%") {
                        verifyTransition(sut: sut, in: window, fractionComplete: 0.9, using: contextSpy, named: "shopping_box_dismiss")
                    }

                    it("should match snapshot at 100%") {
                        verifyTransition(sut: sut, in: window, fractionComplete: 1.0, using: contextSpy, named: "shopping_box_dismiss")
                    }
                }
            }
        }
    }

}
