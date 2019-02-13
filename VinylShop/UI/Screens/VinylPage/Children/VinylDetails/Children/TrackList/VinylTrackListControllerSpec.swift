@testable import VinylShop
import Nimble
import Quick
import SnapshotTesting
import UIKit

class VinylTrackListControllerSpec: QuickSpec {

    override func spec() {
        describe("VinylTrackListController") {
            var sut: VinylTrackListController!

            beforeEach {
                sut = VinylTrackListController(vinyl: .shotDetails)
            }

            afterEach {
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
                        trackListCollectionView = sut.trackListView.collectionView
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

                        describe("1st item") {
                            var cell: VinylSideCell?
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
                            var cell: VinylTrackCell?
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

                        describe("1st item") {
                            var cell: VinylSideCell?
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
                            var cell: VinylTrackCell?
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
        }
    }

}
