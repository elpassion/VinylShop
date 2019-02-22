@testable import VinylShop
import Nimble
import Quick

class ShopRecommendedControllerFactorySpec: QuickSpec {

    override func spec() {
        describe("ShopRecommendedControllerFactory") {
            describe("view model factory") {
                var viewModel: VinylCollectionViewModel!

                beforeEach {
                    viewModel = shopRecommendedViewModelFactory(.shotDetails)
                }

                afterEach {
                    viewModel = nil
                }

                it("should have correct title") {
                    expect(viewModel.title) == "Recommended for you"
                }

                it("should have recommended vinyls") {
                    expect(viewModel.vinyls.map { $0.title }) == [
                        "Master of Puppets",
                        "Papaoutai",
                        "Ghost In The Machine"
                    ]
                }
            }
        }
    }

}
