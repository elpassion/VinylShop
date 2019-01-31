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
