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

            describe("required initializer") {
                it("should return nil") {
                    expect(ShopController(coder: NSCoder())).to(beNil())
                }
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
                        details: .shotDetails,
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
                            newAlbumsControllerStub.vinylSelectedAction?(Vinyl.vinyl(withID: 26))
                        }

                        it("should navigate to vinyl page") {
                            expect(environmentSpy.invokedGoToRoute).to(haveCount(1))
                            expect(environmentSpy.invokedGoToRoute.first) == .vinylPage(id: 26)
                        }
                    }

                    describe("recommended album selection") {
                        beforeEach {
                            recommendedControllerStub.vinylSelectedAction?(Vinyl.vinyl(withID: 3))
                        }

                        it("should navigate to vinyl page") {
                            expect(environmentSpy.invokedGoToRoute).to(haveCount(1))
                            expect(environmentSpy.invokedGoToRoute.first) == .vinylPage(id: 3)
                        }
                    }
                }

                describe("view will appear") {
                    beforeEach {
                        Environment.shared.navigationController.navigationBar.barStyle = .black
                        sut.viewWillAppear(false)
                    }

                    it("should set navigation bar style to default") {
                        expect(Environment.shared.navigationController.navigationBar.barStyle) == .default
                    }
                }
            }

            context("with real child controllers") {
                beforeEach {
                    sut = ShopController(details: .shotDetails)
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

private extension Vinyl {

    static func vinyl(withID id: Int) -> Vinyl {
        return Vinyl(id: id, title: "", band: "", image: "", sides: [], recommendedIDs: [])
    }

}
