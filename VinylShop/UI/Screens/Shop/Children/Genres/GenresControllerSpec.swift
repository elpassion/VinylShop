@testable import VinylShop
import Nimble
import Quick

class GenresControllerSpec: QuickSpec {

    override func spec() {
        describe("GenresController") {
            var sut: GenresController!

            beforeEach {
                sut = GenresController(vinyl: .shotDetails)
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
                        collectionView = sut.genresView.collectionView
                    }

                    afterEach {
                        collectionView = nil
                    }

                    it("should have layout set") {
                        expect(collectionView.collectionViewLayout) === sut.genresView.collectionViewLayout
                    }

                    it("should have 1 section") {
                        expect(collectionView.dataSource?.numberOfSections?(in: collectionView)) == 1
                    }

                    describe("1st section") {
                        it("should have 4 items") {
                            expect(collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: 0)) == 4
                        }

                        describe("1st cell") {
                            var cell: GenreCell?
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

                            it("should have correct name") {
                                expect(cell?.nameLabel.text) == "Rock"
                            }

                            it("should have correct image") {
                                expect(cell?.imageView.image).to(beImage(#imageLiteral(resourceName: "genre_rock")))
                            }

                            it("should have correct size") {
                                expect(size) == CGSize(width: 80, height: 110)
                            }
                        }
                    }
                }
            }
        }
    }

}
