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
                sut = VinylDetailsController(vinyl: .shotDetails)
            }

            afterEach {
                sut = nil
            }

            describe("view did load") {
                beforeEach {
                    _ = sut.view
                }

                it("should embed track list controller") {
                    expect(sut.children).to(containElementSatisfying({ $0 is VinylTrackListController }))
                    expect(sut.detailsView.scrollContentView.arrangedSubviews).to(containElementSatisfying({ $0 is VinylTrackListView }))
                }

                it("should embed recommended controller") {
                    expect(sut.children).to(containElementSatisfying({ $0 is RecommendedController }))
                    expect(sut.detailsView.scrollContentView.arrangedSubviews).to(containElementSatisfying({ $0 is RecommendedView }))
                }

                it("should show header placeholder view") {
                    expect(sut.detailsView.headerPlaceholderView.alpha) == 1.0
                }

                it("should hide header view") {
                    expect(sut.detailsView.headerView.alpha) == 0.0
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
                                scrollView.contentOffset = CGPoint(x: 0, y: 200)
                                scrollView.delegate?.scrollViewDidScroll?(scrollView)
                            }

                            it("should update height constraint to minimum value") {
                                expect(sut.detailsView.headerHeightConstraint?.constant) == 116
                            }

                            it("should hide header placeholder view") {
                                expect(sut.detailsView.headerPlaceholderView.alpha) == 0.0
                            }

                            it("should show header view") {
                                expect(sut.detailsView.headerView.alpha) == 1.0
                            }
                        }

                        context("to header in collapsing state") {
                            beforeEach {
                                scrollView.contentOffset = CGPoint(x: 0, y: 100)
                                scrollView.delegate?.scrollViewDidScroll?(scrollView)
                            }

                            it("should update height constraint to original height minus offset") {
                                expect(sut.detailsView.headerHeightConstraint?.constant) == 150
                            }
                        }

                        context("to header in extended state") {
                            beforeEach {
                                scrollView.contentOffset = CGPoint(x: 0, y: -25)
                                scrollView.delegate?.scrollViewDidScroll?(scrollView)
                            }

                            it("should update height constraint to original height") {
                                expect(sut.detailsView.headerHeightConstraint?.constant) == 250
                            }
                        }
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
                assertSnapshot(matching: sut, as: .image(on: .iPhoneX, size: CGSize(width: 375, height: 1190)))
            }
        }
    }

}
