@testable import VinylShop
import Nimble
import Quick

class RecommendedVinylsRepositorySpec: QuickSpec {

    override func spec() {
        describe("RecommendedVinylsRepository") {
            var sut: RecommendedVinylsRepository!

            beforeEach {
                sut = RecommendedVinylsRepository(details: .shotDetails)
            }

            afterEach {
                sut = nil
            }

            describe("recommended vinyls") {
                var recommendedVinyls: [Vinyl]!

                beforeEach {
                    recommendedVinyls = sut.recommendedVinyls(forVinylWithID: 1)
                }

                afterEach {
                    recommendedVinyls = nil
                }

                it("should return correct vinyls") {
                    expect(recommendedVinyls.map { $0.id }) == [4, 5, 6]
                }
            }
        }
    }

}
