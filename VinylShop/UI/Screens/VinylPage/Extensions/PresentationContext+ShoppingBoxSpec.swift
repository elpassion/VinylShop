@testable import VinylShop
import Nimble
import Quick
import UIKit

class PresentationContext_ShoppingBoxSpec: QuickSpec {

    override func spec() {
        describe("PresentationContext+ShoppingBox") {
            var sut: PresentationContext!

            beforeEach {
                sut = .shoppingBox
            }

            afterEach {
                sut = nil
            }

            it("should have correct ID") {
                expect(sut.id) == .shoppingBox
            }

            it("should create shopping box controller") {
                expect(sut.factory()).to(beAnInstanceOf(ShoppingBoxController.self))
            }

            it("should be animated") {
                expect(sut.animated) == true
            }

            it("should have custom presentation style") {
                expect(sut.presentationStyle) == .custom
            }

            it("should have cross dissolve transition style") {
                expect(sut.transitionStyle) == .crossDissolve
            }

            it("should NOT have present animator") {
                let presentAnimator = sut.transitioningDelegate.animationController?(
                    forPresented: UIViewController(),
                    presenting: UIViewController(),
                    source: UIViewController()
                )

                expect(presentAnimator).to(beNil())
            }

            it("should NOT have dismiss animator") {
                let dismissAnimator = sut.transitioningDelegate.animationController?(forDismissed: UIViewController())

                expect(dismissAnimator).to(beNil())
            }
        }
    }

}
