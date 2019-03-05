@testable import VinylShop
import Nimble
import Quick

class VinylDetailsHeaderSmallTitleViewSpec: QuickSpec {

    override func spec() {
        describe("VinylDetailsHeaderSmallTitleView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(VinylDetailsHeaderSmallTitleView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
