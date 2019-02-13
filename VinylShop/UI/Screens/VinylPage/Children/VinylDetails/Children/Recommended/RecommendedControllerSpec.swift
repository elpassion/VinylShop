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
                }
            }
        }
    }

}
