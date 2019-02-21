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

            context("with children controllers' stubs") {
                var barControllerStub: ShoppingBarControllerStub!
                var detailsControllerStub: VinylDetailsControllerStub!
                var buyAnimatorSpy: BuyAnimatorSpy!
                var environmentSpy: EnvironmentSpy!

                beforeEach {
                    barControllerStub = ShoppingBarControllerStub()
                    detailsControllerStub = VinylDetailsControllerStub()
                    buyAnimatorSpy = BuyAnimatorSpy()
                    environmentSpy = EnvironmentSpy()
                    environmentSpy.install()

                    sut = VinylPageController(
                        barControllerFactory: { barControllerStub },
                        detailsControllerFactory: { detailsControllerStub },
                        buyAnimator: buyAnimatorSpy
                    )
                }

                afterEach {
                    environmentSpy.uninstall()
                    environmentSpy = nil
                    buyAnimatorSpy = nil
                    detailsControllerStub = nil
                    barControllerStub = nil
                }

                describe("view did load") {
                    beforeEach {
                        _ = sut.view
                    }

                    it("should embed bar controller in a container view") {
                        expect(sut).to(embed(controller: barControllerStub, in: sut.pageView.barContainerView))
                    }

                    it("should embed details controller in a view") {
                        expect(sut).to(embed(controller: detailsControllerStub, in: sut.pageView.detailsContainerView))
                    }

                    it("should hide bar controller view") {
                        expect(barControllerStub.view.isHidden) == true
                    }

                    describe("shopping bar tap") {
                        beforeEach {
                            barControllerStub.barView.frameControl.simulateTap()
                        }

                        it("should present shopping box controller") {
                            expect(environmentSpy.invokedPresent).to(haveCount(1))
                            expect(environmentSpy.invokedPresent.first?.id) == .shoppingBox
                        }
                    }

                    describe("go back action") {
                        beforeEach {
                            detailsControllerStub.goBackAction?()
                        }

                        it("should invoke go back on navigation environment") {
                            expect(environmentSpy.invokedGoBackCount) == 1
                        }
                    }

                    describe("buy action") {
                        beforeEach {
                            detailsControllerStub.buyAction?()
                        }

                        it("should invoke buy animator") {
                            expect(buyAnimatorSpy.invokedAnimateBuy).toNot(beNil())
                            expect(buyAnimatorSpy.invokedAnimateBuy?.view) === sut.view
                            expect(buyAnimatorSpy.invokedAnimateBuy?.detailsView) === detailsControllerStub.detailsView
                            expect(buyAnimatorSpy.invokedAnimateBuy?.barView) === barControllerStub.barView
                            expect(buyAnimatorSpy.invokedAnimateBuy?.count) == 1
                        }

                        describe("another buy action") {
                            beforeEach {
                                detailsControllerStub.buyAction?()
                            }

                            it("should NOT invoke buy animator again") {
                                expect(buyAnimatorSpy.invokedAnimateBuy?.count) == 1
                            }
                        }

                        context("when buy action is completed") {
                            beforeEach {
                                buyAnimatorSpy.invokedAnimateBuy?.completion()
                            }

                            describe("another buy action") {
                                beforeEach {
                                    detailsControllerStub.buyAction?()
                                }

                                it("should invoke buy animator again") {
                                    expect(buyAnimatorSpy.invokedAnimateBuy?.count) == 2
                                }
                            }
                        }
                    }
                }

                describe("view will appear") {
                    beforeEach {
                        Environment.shared.navigationController.navigationBar.barStyle = .default
                        sut.viewWillAppear(false)
                    }

                    it("should set navigation bar style to black") {
                        expect(Environment.shared.navigationController.navigationBar.barStyle) == .black
                    }
                }
            }

            context("with real child controllers") {
                beforeEach {
                    sut = VinylPageController()
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
