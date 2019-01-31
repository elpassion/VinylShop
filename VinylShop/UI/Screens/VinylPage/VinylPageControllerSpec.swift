@testable import VinylShop
import Nimble
import Quick
import SnapshotTesting
import UIKit

class VinylPageControllerSpec: QuickSpec {

    override func spec() {
        describe("VinylPageController") {
            var sut: VinylPageController!

            afterEach {
                sut = nil
            }

            context("with a bar controller stub") {
                var barControllerStub: UIViewController!

                beforeEach {
                    barControllerStub = UIViewController()
                    sut = VinylPageController(barControllerFactory: { barControllerStub })
                }

                afterEach {
                    barControllerStub = nil
                }

                describe("view did load") {
                    beforeEach {
                        _ = sut.view
                    }

                    it("should embed bar controller in a container view") {
                        expect(sut).to(embed(controller: barControllerStub, in: sut.pageView.barContainerView))
                    }
                }
            }

            context("with real bar controller") {
                beforeEach {
                    sut = VinylPageController(barControllerFactory: ShoppingBarController.init)
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

}
