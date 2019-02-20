@testable import VinylShop
import Nimble
import Quick

class RecommendedControllerFactorySpec: QuickSpec {

    override func spec() {
        describe("RecommendedControllerFactory") {
            describe("view model factory") {
                var viewModel: VinylCollectionViewModel!

                beforeEach {
                    viewModel = recommendedViewModelFactory(.shotDetails)
                }

                afterEach {
                    viewModel = nil
                }

                it("should have correct title") {
                    expect(viewModel.title) == "Recommended for you"
                }

                it("should have recommended vinyls") {
                    expect(viewModel.vinyls.map { $0.title }) == VinylDetails.shotDetails.recommended.map { $0.title }
                }
            }
        }
    }

}
