@testable import VinylShop
import Nimble
import Quick

class VinylDetailsFeaturesViewSpec: QuickSpec {

    override func spec() {
        describe("VinylDetailsFeaturesView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(VinylDetailsFeaturesView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
