@testable import VinylShop
import Nimble
import Quick

class VinylRecommendedControllerFactorySpec: QuickSpec {

    override func spec() {
        describe("VinylRecommendedControllerFactory") {
            describe("view model factory") {
                var viewModel: VinylCollectionViewModel!

                beforeEach {
                    viewModel = vinylRecommendedViewModelFactory(.testVinyl)
                }

                afterEach {
                    viewModel = nil
                }

                it("should have correct title") {
                    expect(viewModel.title) == "Recommended for you"
                }

                it("should have recommended vinyls") {
                    expect(viewModel.vinyls.map { $0.id }) == [1, 2, 3]
                }
            }
        }
    }

}
