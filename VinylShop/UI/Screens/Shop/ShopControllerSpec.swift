@testable import VinylShop
import Nimble
import Quick
import SnapshotTesting
import UIKit

class ShopControllerSpec: QuickSpec {

    override func spec() {
        describe("ShopController") {
            var sut: ShopController!

            afterEach {
                sut = nil
            }

            context("with fake child controllers") {
                var newAlbumsControllerStub: UIViewController!
                var genresControllerStub: UIViewController!
                var recommendedControllerStub: UIViewController!

                beforeEach {
                    newAlbumsControllerStub = UIViewController()
                    genresControllerStub = UIViewController()
                    recommendedControllerStub = UIViewController()

                    sut = ShopController(
                        vinyl: .shotDetails,
                        newFactory: { _ in newAlbumsControllerStub },
                        genresFactory: { _ in genresControllerStub },
                        recommendedFactory: { _ in recommendedControllerStub }
                    )
                }

                afterEach {
                    newAlbumsControllerStub = nil
                    genresControllerStub = nil
                    recommendedControllerStub = nil
                }

                describe("view did load") {
                    beforeEach {
                        _ = sut.view
                    }

                    it("should embed new albums controller") {
                        expect(sut).to(embed(controller: newAlbumsControllerStub, in: sut.shopView.scrollContentView))
                    }

                    it("should embed new genres controller") {
                        expect(sut).to(embed(controller: genresControllerStub, in: sut.shopView.scrollContentView))
                    }

                    it("should embed recommended controller") {
                        expect(sut).to(embed(controller: recommendedControllerStub, in: sut.shopView.scrollContentView))
                    }
                }
            }

            context("with real child controllers") {
                beforeEach {
                    sut = ShopController(vinyl: .shotDetails)
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
