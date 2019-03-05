@testable import VinylShop
import Nimble
import Quick
import UIKit

class ShoppingBoxItemsViewSpec: QuickSpec {

    override func spec() {
        describe("ShoppingBoxItemsView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(ShoppingBoxItemsView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
