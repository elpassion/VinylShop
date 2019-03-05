@testable import VinylShop
import Nimble
import Quick

class ShopViewSpec: QuickSpec {

    override func spec() {
        describe("ShopView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(ShopView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
