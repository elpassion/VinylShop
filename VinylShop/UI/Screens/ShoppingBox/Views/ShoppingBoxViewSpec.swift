@testable import VinylShop
import Nimble
import Quick
import UIKit

class ShoppingBoxViewSpec: QuickSpec {

    override func spec() {
        describe("ShoppingBoxView") {
            var sut: ShoppingBoxView!

            beforeEach {
                sut = ShoppingBoxView()
            }

            afterEach {
                sut = nil
            }

            describe("required initializer") {
                it("should return nil") {
                    expect(ShoppingBoxView(coder: NSCoder())).to(beNil())
                }
            }

            describe("swipe gesture recognizer") {
                it("should detect swipe down") {
                    expect(sut.swipeGestureRecognizer.direction) == .down
                }

                it("should be added to a box view") {
                    expect(sut.boxView.gestureRecognizers).to(contain(sut.swipeGestureRecognizer))
                }
            }

            describe("tap gesture recognizer") {
                it("should be added to a dimmed background view") {
                    expect(sut.dimmedBackgroundView.gestureRecognizers).to(contain(sut.tapGestureRecognizer))
                }
            }
        }
    }

}
