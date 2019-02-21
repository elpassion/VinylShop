@testable import VinylShop
import Nimble
import Quick

class VinylPagePopAnimatorSpec: QuickSpec {

    override func spec() {
        describe("VinylPagePopAnimator") {
            var sut: VinylPagePopAnimator!

            beforeEach {
                sut = VinylPagePopAnimator(vinylID: 32)
            }

            afterEach {
                sut = nil
            }

            it("should have correct vinyl ID") {
                expect(sut.vinylID) == 32
            }

            describe("transition duration") {
                it("should return correct duration") {
                    expect(sut.transitionDuration(using: nil)) == 0.83
                }
            }
        }
    }

}
