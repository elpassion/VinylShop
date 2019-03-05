@testable import VinylShop
import Nimble
import Quick

class VinylPageViewSpec: QuickSpec {

    override func spec() {
        describe("VinylPageView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(VinylPageView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
