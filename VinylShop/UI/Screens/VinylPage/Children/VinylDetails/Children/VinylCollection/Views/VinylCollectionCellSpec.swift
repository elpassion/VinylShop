@testable import VinylShop
import Nimble
import Quick

class VinylCollectionCellSpec: QuickSpec {

    override func spec() {
        describe("VinylCollectionCell") {
            describe("required initializer") {
                it("should return nil") {
                    expect(VinylCollectionCell(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
