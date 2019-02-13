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
                let sideOne = Side(name: "1")
                let sideTwo = Side(name: "2")

                sut = VinylDetailsController(sides: [sideOne, sideTwo])

                record = true
            }

            afterEach {
                record = false
                sut = nil
            }

            describe("view did load") {
                beforeEach {
                    _ = sut.view
                }

                describe("track list") {
                    var trackListCollectionView: UICollectionView!

                    beforeEach {
                        trackListCollectionView = sut.detailsView.trackListView.collectionView
                    }

                    afterEach {
                        trackListCollectionView = nil
                    }

                    it("should have 2 sections") {
                        expect(trackListCollectionView.dataSource?.numberOfSections?(in: trackListCollectionView)) == 2
                    }

                    describe("1st section") {
                        it("should have 1 item") {
                            expect(trackListCollectionView.dataSource?.collectionView(trackListCollectionView, numberOfItemsInSection: 0)) == 1
                        }

                        describe("1st item") {
                            var cell: VinylDetailsSideCell?
                            var size: CGSize!

                            beforeEach {
                                cell = trackListCollectionView.cell(inSection: 0, atItem: 0)
                                size = trackListCollectionView.size(inSection: 0, atItem: 0)
                            }

                            afterEach {
                                cell = nil
                                size = nil
                            }

                            it("should be dequeued") {
                                expect(cell).toNot(beNil())
                            }

                            it("should have correct title") {
                                expect(cell?.titleLabel.text) == "Side 1"
                            }

                            it("should have correct size") {
                                expect(size) == CGSize(width: 54, height: 20)
                            }
                        }
                    }

                    describe("2nd section") {
                        it("should have 1 item") {
                            expect(trackListCollectionView.dataSource?.collectionView(trackListCollectionView, numberOfItemsInSection: 1)) == 1
                        }

                        describe("1st item") {
                            var cell: VinylDetailsSideCell?
                            var size: CGSize!

                            beforeEach {
                                cell = trackListCollectionView.cell(inSection: 1, atItem: 0)
                                size = trackListCollectionView.size(inSection: 1, atItem: 0)
                            }

                            afterEach {
                                cell = nil
                                size = nil
                            }

                            it("should be dequeued") {
                                expect(cell).toNot(beNil())
                            }

                            it("should have correct title") {
                                expect(cell?.titleLabel.text) == "Side 2"
                            }

                            it("should have correct size") {
                                expect(size) == CGSize(width: 54, height: 20)
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
        }
    }

}
