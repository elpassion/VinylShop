@testable import VinylShop
import Nimble
import Quick
import UIKit

class ShoppingBoxFooterViewSpec: QuickSpec {

    override func spec() {
        describe("ShoppingBoxFooterView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(ShoppingBoxFooterView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
