@testable import VinylShop
import Nimble
import Quick
import UIKit

class ShoppingBoxPriceViewSpec: QuickSpec {

    override func spec() {
        describe("ShoppingBoxPriceView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(ShoppingBoxPriceView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
