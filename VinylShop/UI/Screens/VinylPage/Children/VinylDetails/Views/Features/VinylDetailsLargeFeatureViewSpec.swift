@testable import VinylShop
import Nimble
import Quick

class VinylDetailsLargeFeatureViewSpec: QuickSpec {

    override func spec() {
        describe("VinylDetailsLargeFeatureView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(VinylDetailsLargeFeatureView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
