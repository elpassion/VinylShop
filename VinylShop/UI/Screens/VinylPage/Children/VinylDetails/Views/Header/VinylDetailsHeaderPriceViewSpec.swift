@testable import VinylShop
import Nimble
import Quick

class VinylDetailsHeaderPriceViewSpec: QuickSpec {

    override func spec() {
        describe("VinylDetailsHeaderPriceView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(VinylDetailsHeaderPriceView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
