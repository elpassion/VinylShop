@testable import VinylShop
import Nimble
import Quick

class VinylDetailsViewSpec: QuickSpec {

    override func spec() {
        describe("VinylDetailsView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(VinylDetailsView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
