@testable import VinylShop
import Nimble
import Quick

class VinylSideCellSpec: QuickSpec {

    override func spec() {
        describe("VinylSideCell") {
            describe("required initializer") {
                it("should return nil") {
                    expect(VinylSideCell(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
