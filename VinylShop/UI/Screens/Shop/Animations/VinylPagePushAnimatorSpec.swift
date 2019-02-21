@testable import VinylShop
import Nimble
import Quick

class VinylPagePushAnimatorSpec: QuickSpec {

    override func spec() {
        describe("VinylPagePushAnimator") {
            var sut: VinylPagePushAnimator!

            beforeEach {
                sut = VinylPagePushAnimator(vinylID: 93)
            }

            afterEach {
                sut = nil
            }

            it("should have correct vinyl ID") {
                expect(sut.vinylID) == 93
            }

            describe("transition duration") {
                it("should return correct duration") {
                    expect(sut.transitionDuration(using: nil)) == 0.83
                }
            }
        }
    }

}
