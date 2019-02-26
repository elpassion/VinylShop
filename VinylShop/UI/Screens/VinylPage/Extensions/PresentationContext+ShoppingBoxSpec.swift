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

            it("should have over current context presentation style") {
                expect(sut.presentationStyle) == .overCurrentContext
            }

            it("should have cross dissolve transition style") {
                expect(sut.transitionStyle) == .crossDissolve
            }

            it("should have present animator of ShoppingBoxPresentationAnimator type") {
                let presentAnimator = sut.transitioner.animationController?(
                    forPresented: UIViewController(),
                    presenting: UIViewController(),
                    source: UIViewController()
                )

                expect(presentAnimator).to(beAnInstanceOf(ShoppingBoxPresentationAnimator.self))
            }

            it("should have dismiss animator of ShoppingBoxDismissAnimator type") {
                let dismissAnimator = sut.transitioner.animationController?(forDismissed: UIViewController())

                expect(dismissAnimator).to(beAnInstanceOf(ShoppingBoxDismissAnimator.self))
            }
        }
    }

}
