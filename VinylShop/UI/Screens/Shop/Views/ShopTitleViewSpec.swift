@testable import VinylShop
import Nimble
import Quick

class ShopTitleViewSpec: QuickSpec {

    override func spec() {
        describe("ShopTitleView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(ShopTitleView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
