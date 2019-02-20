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
                var newAlbumsControllerStub: VinylCollectionControllerStub!
                var genresControllerStub: UIViewController!
                var recommendedControllerStub: VinylCollectionControllerStub!
                var environmentSpy: EnvironmentSpy!

                beforeEach {
                    newAlbumsControllerStub = VinylCollectionControllerStub()
                    genresControllerStub = UIViewController()
                    recommendedControllerStub = VinylCollectionControllerStub()
                    environmentSpy = EnvironmentSpy()
                    environmentSpy.install()

                    sut = ShopController(
                        vinyl: .shotDetails,
                        newFactory: { _ in newAlbumsControllerStub },
                        genresFactory: { _ in genresControllerStub },
                        recommendedFactory: { _ in recommendedControllerStub }
                    )
                }

                afterEach {
                    environmentSpy.uninstall()
                    newAlbumsControllerStub = nil
                    genresControllerStub = nil
                    recommendedControllerStub = nil
                    environmentSpy = nil
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

                    describe("new album selection") {
                        beforeEach {
                            newAlbumsControllerStub.vinylSelectedAction?(Vinyl(title: "", band: "", image: nil))
                        }

                        it("should navigate to vinyl page") {
                            expect(environmentSpy.invokedGoToRoute).to(haveCount(1))
                            expect(environmentSpy.invokedGoToRoute.first) == .vinylPage
                        }
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
