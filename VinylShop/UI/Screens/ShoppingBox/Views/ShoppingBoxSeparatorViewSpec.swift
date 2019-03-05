@testable import VinylShop
import Nimble
import Quick
import UIKit

class ShoppingBoxSeparatorViewSpec: QuickSpec {

    override func spec() {
        describe("ShoppingBoxSeparatorView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(ShoppingBoxSeparatorView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
