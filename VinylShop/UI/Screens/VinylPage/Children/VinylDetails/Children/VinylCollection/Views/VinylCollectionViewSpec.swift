@testable import VinylShop
import Nimble
import Quick

class VinylCollectionViewSpec: QuickSpec {

    override func spec() {
        describe("VinylCollectionView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(VinylCollectionView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
