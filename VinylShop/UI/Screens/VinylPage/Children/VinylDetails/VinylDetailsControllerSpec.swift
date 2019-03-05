@testable import VinylShop
import Nimble
import Quick
import SnapshotTesting
import UIKit

class VinylDetailsControllerSpec: QuickSpec {

    override func spec() {
        describe("VinylDetailsController") {
            var sut: VinylDetailsController!

            beforeEach {
                sut = VinylDetailsController(vinyl: .testVinyl)
            }

            afterEach {
                sut = nil
            }

            describe("required initializer") {
                it("should return nil") {
                    expect(VinylDetailsController(coder: NSCoder())).to(beNil())
                }
            }

            describe("view did load") {
                beforeEach {
                    _ = sut.view
                }

                it("should embed track list controller") {
                    expect(sut.children).to(containElementSatisfying({ $0 is VinylTrackListController }))
                    expect(sut.detailsView.scrollContentView.arrangedSubviews).to(containElementSatisfying({ $0 is VinylTrackListView }))
                }

                it("should embed vinyl collection controller") {
                    expect(sut.children).to(containElementSatisfying({ $0 is VinylCollectionController }))
                    expect(sut.detailsView.scrollContentView.arrangedSubviews).to(containElementSatisfying({ $0 is VinylCollectionView }))
                }

                describe("scroll view") {
                    var scrollView: UIScrollView!

                    beforeEach {
                        scrollView = sut.detailsView.scrollView
                    }

                    afterEach {
                        scrollView = nil
                    }

                    it("should have bottom content inset") {
                        expect(scrollView.contentInset) == UIEdgeInsets(top: 0.0, left: 0.0, bottom: 80.0, right: 0.0)
                    }

                    describe("did scroll") {
                        beforeEach {
                            sut.detailsView.headerPlaceholderView.frame = CGRect(x: 0, y: 0, width: 300, height: 250)
                        }

                        context("to collapsed header") {
                            beforeEach {
                                scrollView.setContentOffset(CGPoint(x: 0, y: 200), animated: false)
                                scrollView.delegate?.scrollViewDidScroll?(scrollView)
                            }

                            it("should update height constraint to minimum value") {
                                expect(sut.detailsView.headerHeightConstraint?.constant) == -134
                            }

                            it("should hide header placeholder view") {
                                expect(sut.detailsView.headerPlaceholderView.alpha) == 0.0
                            }

                            it("should show header view") {
                                expect(sut.detailsView.headerView.alpha) == 1.0
                            }

                            it("should hide large title view") {
                                expect(sut.detailsView.headerView.largeTitleView.alpha) == 0.0
                            }

                            it("should fully show small title view") {
                                expect(sut.detailsView.headerView.smallTitleView.alpha) == 1.0
                            }

                            it("should update cover image size to collapsed size") {
                                expect(sut.detailsView.headerView.coverSizeConstraint?.first.constant) == 63.0 ± 0.1
                                expect(sut.detailsView.headerView.coverSizeConstraint?.second.constant) == 63.0 ± 0.1
                            }

                            it("should update vinyl offset to collapsed offset") {
                                expect(sut.detailsView.headerView.vinylCenterOffsetConstraint?.constant) == 20.2 ± 0.1
                            }

                            it("should deactivate large title bottom constraint") {
                                expect(sut.detailsView.headerView.largeBottomAnchorConstraint?.isActive) == false
                            }

                            it("should activate small title bottom constraint") {
                                expect(sut.detailsView.headerView.smallBottomAnchorConstraint?.isActive) == true
                            }
                        }

                        context("to header in collapsing state") {
                            beforeEach {
                                scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: false)
                                scrollView.delegate?.scrollViewDidScroll?(scrollView)
                            }

                            it("should update height constraint to original height minus offset") {
                                expect(sut.detailsView.headerHeightConstraint?.constant) == -100
                            }

                            it("should deactivate large title bottom constraint") {
                                expect(sut.detailsView.headerView.largeBottomAnchorConstraint?.isActive) == false
                            }

                            it("should activate small title bottom constraint") {
                                expect(sut.detailsView.headerView.smallBottomAnchorConstraint?.isActive) == true
                            }
                        }

                        context("to header in extended state") {
                            beforeEach {
                                scrollView.setContentOffset(CGPoint(x: 0, y: -25), animated: false)
                                scrollView.delegate?.scrollViewDidScroll?(scrollView)
                            }

                            it("should update height constraint to original height") {
                                expect(sut.detailsView.headerHeightConstraint?.constant) == 0
                            }

                            it("should fully show large title view") {
                                expect(sut.detailsView.headerView.largeTitleView.alpha) == 1.0
                            }

                            it("should hide small title view") {
                                expect(sut.detailsView.headerView.smallTitleView.alpha) == 0.0
                            }

                            it("should update cover image size to extended size") {
                                expect(sut.detailsView.headerView.coverSizeConstraint?.first.constant) == 140.0 ± 0.1
                                expect(sut.detailsView.headerView.coverSizeConstraint?.second.constant) == 140.0 ± 0.1
                            }

                            it("should update vinyl offset to extended offset") {
                                expect(sut.detailsView.headerView.vinylCenterOffsetConstraint?.constant) == 45.0 ± 0.1
                            }

                            it("should activate large title bottom constraint") {
                                expect(sut.detailsView.headerView.largeBottomAnchorConstraint?.isActive) == true
                            }

                            it("should deactivate small title bottom constraint") {
                                expect(sut.detailsView.headerView.smallBottomAnchorConstraint?.isActive) == false
                            }
                        }
                    }
                }

                describe("back button tap") {
                    var goBackActionInvoked: Bool?

                    beforeEach {
                        sut.goBackAction = { goBackActionInvoked = true }
                        sut.detailsView.headerView.backButton.simulateTap()
                    }

                    afterEach {
                        goBackActionInvoked = nil
                    }

                    it("should invoke go back action") {
                        expect(goBackActionInvoked) == true
                    }
                }

                describe("buy button tap") {
                    var buyActionInvoked: Bool?

                    beforeEach {
                        sut.buyAction = { buyActionInvoked = true }
                        sut.detailsView.headerView.buyButton.simulateTap()
                    }

                    afterEach {
                        buyActionInvoked = nil
                    }

                    it("should invoke buy action") {
                        expect(buyActionInvoked) == true
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

            it("should match full height snapshot on iPhone X") {
                assertSnapshot(matching: sut, as: .image(on: .iPhoneX, size: CGSize(width: 375, height: 1_234)))
            }
        }
    }

}
