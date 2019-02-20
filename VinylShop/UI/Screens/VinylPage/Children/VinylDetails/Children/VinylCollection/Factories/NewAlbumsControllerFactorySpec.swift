@testable import VinylShop
import Nimble
import Quick

class NewAlbumsControllerFactorySpec: QuickSpec {

    override func spec() {
        describe("NewAlbumsControllerFactory") {
            describe("view model factory") {
                var viewModel: VinylCollectionViewModel!

                beforeEach {
                    viewModel = newAlbumsViewModelFactory(.shotDetails)
                }

                afterEach {
                    viewModel = nil
                }

                it("should have correct title") {
                    expect(viewModel.title) == "New albums"
                }

                it("should have new vinyls") {
                    expect(viewModel.vinyls.map { $0.title }) == VinylDetails.shotDetails.new.map { $0.title }
                }
            }
        }
    }

}
