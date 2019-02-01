@testable import VinylShop
import Nimble
import Quick
import SnapshotTesting

class ShoppingBarControllerSpec: QuickSpec {

    override func spec() {
        describe("ShoppingBarController") {
            var sut: ShoppingBarController!

            beforeEach {
                sut = ShoppingBarController()
            }

            afterEach {
                sut = nil
            }

            describe("view did load") {
                beforeEach {
                    _ = sut.view
                }

                describe("bar control") {
                    it("should return frame control") {
                        expect(sut.barControl) === sut.barView.frameControl
                    }
                }
            }

            it("should match snapshot on iPhone SE") {
                assertSnapshot(matching: sut, as: .image(on: .iPhoneSe))
            }

            it("should match snapshot on iPhone 8") {
                assertSnapshot(matching: sut, as: .image(on: .iPhone8))
            }

            it("should match snapshot on iPhone 8 Plus") {
                assertSnapshot(matching: sut, as: .image(on: .iPhone8Plus))
            }

            it("should match snapshot on iPhone X") {
                assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
            }

            it("should match snapshot on iPhone Xs Max") {
                assertSnapshot(matching: sut, as: .image(on: .iPhoneXsMax))
            }
        }
    }

}
