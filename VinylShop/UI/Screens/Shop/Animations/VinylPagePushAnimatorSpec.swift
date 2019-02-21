@testable import VinylShop
import Nimble
import Quick

class VinylPagePushAnimatorSpec: QuickSpec {

    override func spec() {
        describe("VinylPagePushAnimator") {
            var sut: VinylPagePushAnimator!

            beforeEach {
                sut = VinylPagePushAnimator()
            }

            afterEach {
                sut = nil
            }

            describe("transition duration") {
                it("should return correct duration") {
                    expect(sut.transitionDuration(using: nil)) == 0.83
                }
            }
        }
    }

}
