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
                let sides = [
                    Side(name: "1", tracks: [
                        Track(position: "1", name: "Overture", duration: "3:34"),
                        Track(position: "2", name: "A Good Part", duration: "3:47"),
                        Track(position: "3", name: "Weak", duration: "3:21"),
                        Track(position: "4", name: "Sober Up", duration: "3:38")
                    ]),
                    Side(name: "2", tracks: [
                        Track(position: "5", name: "Drama", duration: "4:08"),
                        Track(position: "6", name: "Turning Out", duration: "3:54"),
                        Track(position: "7", name: "No Grass Today", duration: "3:39"),
                        Track(position: "8", name: "Call My Dad", duration: "4:15")
                    ])
                ]

                sut = VinylDetailsController(vinyl: VinylDetails(sides: sides))

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
                    var flowLayoutDelegate: UICollectionViewDelegateFlowLayout?

                    beforeEach {
                        trackListCollectionView = sut.detailsView.trackListView.collectionView
                        flowLayoutDelegate = trackListCollectionView.delegate as? UICollectionViewDelegateFlowLayout
                    }

                    afterEach {
                        trackListCollectionView = nil
                        flowLayoutDelegate = nil
                    }

                    it("should have 2 sections") {
                        expect(trackListCollectionView.dataSource?.numberOfSections?(in: trackListCollectionView)) == 2
                    }

                    it("should have delegate set") {
                        expect(flowLayoutDelegate).toNot(beNil())
                    }

                    describe("1st section") {
                        it("should have 5 items") {
                            expect(trackListCollectionView.dataSource?.collectionView(trackListCollectionView, numberOfItemsInSection: 0)) == 5
                        }

                        it("should have correct insets") {
                            let insets = flowLayoutDelegate?.collectionView?(
                                trackListCollectionView,
                                layout: trackListCollectionView.collectionViewLayout,
                                insetForSectionAt: 0
                            )

                            expect(insets) == UIEdgeInsets.zero
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
                                expect(size) == CGSize(width: 222, height: 28)
                            }
                        }

                        describe("2nd item") {
                            var cell: VinylDetailsTrackCell?
                            var size: CGSize!

                            beforeEach {
                                cell = trackListCollectionView.cell(inSection: 0, atItem: 1)
                                size = trackListCollectionView.size(inSection: 0, atItem: 1)
                            }

                            afterEach {
                                cell = nil
                                size = nil
                            }

                            it("should be dequeued") {
                                expect(cell).toNot(beNil())
                            }

                            it("should have correct position") {
                                expect(cell?.positionLabel.text) == "1"
                            }

                            it("should have correct name") {
                                expect(cell?.nameLabel.text) == "Overture"
                            }

                            it("should have correct duration") {
                                expect(cell?.durationLabel.text) == "3:34"
                            }

                            it("should have correct size") {
                                expect(size) == CGSize(width: 222, height: 50)
                            }
                        }
                    }

                    describe("2nd section") {
                        it("should have 5 items") {
                            expect(trackListCollectionView.dataSource?.collectionView(trackListCollectionView, numberOfItemsInSection: 1)) == 5
                        }

                        it("should have correct insets") {
                            let insets = flowLayoutDelegate?.collectionView?(
                                trackListCollectionView,
                                layout: trackListCollectionView.collectionViewLayout,
                                insetForSectionAt: 1
                            )

                            expect(insets) == UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
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
                                expect(size) == CGSize(width: 222, height: 28)
                            }
                        }

                        describe("5th item") {
                            var cell: VinylDetailsTrackCell?
                            var size: CGSize!

                            beforeEach {
                                cell = trackListCollectionView.cell(inSection: 1, atItem: 4)
                                size = trackListCollectionView.size(inSection: 1, atItem: 4)
                            }

                            afterEach {
                                cell = nil
                                size = nil
                            }

                            it("should be dequeued") {
                                expect(cell).toNot(beNil())
                            }

                            it("should have correct position") {
                                expect(cell?.positionLabel.text) == "8"
                            }

                            it("should have correct name") {
                                expect(cell?.nameLabel.text) == "Call My Dad"
                            }

                            it("should have correct duration") {
                                expect(cell?.durationLabel.text) == "4:15"
                            }

                            it("should have correct size") {
                                expect(size) == CGSize(width: 222, height: 50)
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
