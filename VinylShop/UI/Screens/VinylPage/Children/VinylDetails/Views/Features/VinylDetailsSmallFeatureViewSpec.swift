@testable import VinylShop
import Nimble
import Quick

class VinylDetailsSmallFeatureViewSpec: QuickSpec {

    override func spec() {
        describe("VinylDetailsSmallFeatureView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(VinylDetailsSmallFeatureView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
