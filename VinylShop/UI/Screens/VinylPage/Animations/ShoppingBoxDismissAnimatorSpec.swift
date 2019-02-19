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
        }
    }

}
