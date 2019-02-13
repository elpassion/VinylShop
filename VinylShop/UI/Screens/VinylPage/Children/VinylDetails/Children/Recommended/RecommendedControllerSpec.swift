@testable import VinylShop
import Nimble
import Quick
import UIKit

class RecommendedControllerSpec: QuickSpec {

    override func spec() {
        describe("RecommendedController") {
            var sut: RecommendedController!

            beforeEach {
                sut = RecommendedController(vinyl: .testDetails)
            }

            afterEach {
                sut = nil
            }

            describe("view did load") {
                beforeEach {
                    _ = sut.view
                }

                describe("collection view") {
                    var collectionView: UICollectionView!

                    beforeEach {
                        collectionView = sut.recommendedView.collectionView
                    }

                    afterEach {
                        collectionView = nil
                    }

                    it("should have layout set") {
                        expect(collectionView.collectionViewLayout) === sut.recommendedView.collectionViewLayout
                    }

                    it("should have 1 section") {
                        expect(collectionView.dataSource?.numberOfSections?(in: collectionView)) == 1
                    }

                    describe("1st section") {
                        it("should have 3 items") {
                            expect(collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: 0)) == 3
                        }

                        describe("1st cell") {
                            var cell: RecommendedCell?
                            var size: CGSize!

                            beforeEach {
                                cell = collectionView.cell(inSection: 0, atItem: 0)
                                size = collectionView.size(inSection: 0, atItem: 0)
                            }

                            afterEach {
                                cell = nil
                                size = nil
                            }

                            it("should be dequeued") {
                                expect(cell).toNot(beNil())
                            }

                            it("should have correct title") {
                                expect(cell?.titleLabel.text) == "Master of Puppets"
                            }

                            it("should have correct band") {
                                expect(cell?.bandLabel.text) == "Metallica"
                            }

                            it("should have correct image") {
                                expect(cell?.coverImageView.image).to(beImage(#imageLiteral(resourceName: "cover_metallica")))
                            }

                            it("should have correct size") {
                                expect(size) == CGSize(width: 114, height: 180)
                            }
                        }
                    }
                }
            }
        }
    }

}
