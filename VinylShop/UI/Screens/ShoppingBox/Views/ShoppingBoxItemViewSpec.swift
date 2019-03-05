@testable import VinylShop
import Nimble
import Quick
import UIKit

class ShoppingBoxItemViewSpec: QuickSpec {

    override func spec() {
        describe("ShoppingBoxItemView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(ShoppingBoxItemView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
