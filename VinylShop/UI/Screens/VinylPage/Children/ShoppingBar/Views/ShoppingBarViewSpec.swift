@testable import VinylShop
import Nimble
import Quick

class ShoppingBarViewSpec: QuickSpec {

    override func spec() {
        describe("ShoppingBarView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(ShoppingBarView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
