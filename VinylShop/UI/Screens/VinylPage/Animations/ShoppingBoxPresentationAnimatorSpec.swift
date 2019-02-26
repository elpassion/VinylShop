@testable import VinylShop
import Nimble
import Quick

class ShoppingBoxPresentationAnimatorSpec: QuickSpec {

    override func spec() {
        describe("ShoppingBoxPresentationAnimator") {
            var sut: ShoppingBoxPresentationAnimator!

            beforeEach {
                sut = ShoppingBoxPresentationAnimator()
            }

            afterEach {
                sut = nil
            }

            it("should return correct transition duration") {
                expect(sut.transitionDuration(using: nil)) == 0.76
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

                    it("should complete transition") {
                        expect(contextSpy.invokedCompleteWith) == true
                    }
                }
            }
        }
    }

}
