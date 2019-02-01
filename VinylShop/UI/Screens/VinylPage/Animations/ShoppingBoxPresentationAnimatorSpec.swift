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
                expect(sut.transitionDuration(using: nil)) == 1.0
            }
        }
    }

}
