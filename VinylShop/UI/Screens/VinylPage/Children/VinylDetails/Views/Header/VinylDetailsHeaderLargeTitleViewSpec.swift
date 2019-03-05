@testable import VinylShop
import Nimble
import Quick

class VinylDetailsHeaderLargeTitleViewSpec: QuickSpec {

    override func spec() {
        describe("VinylDetailsHeaderLargeTitleView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(VinylDetailsHeaderLargeTitleView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
