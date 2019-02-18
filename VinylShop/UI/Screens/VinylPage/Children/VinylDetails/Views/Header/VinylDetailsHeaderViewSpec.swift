@testable import VinylShop
import Nimble
import Quick
import UIKit

class VinylDetailsHeaderViewSpec: QuickSpec {

    override func spec() {
        describe("VinylDetailsHeaderView") {
            var sut: VinylDetailsHeaderView!

            beforeEach {
                sut = VinylDetailsHeaderView()
                sut.frame = CGRect(x: 0, y: 0, width: 300, height: 200)

                sut.setNeedsLayout()
                sut.layoutIfNeeded()
            }

            afterEach {
                sut = nil
            }

            describe("buy button") {
                it("should have non-zero frame") {
                    expect(sut.buyButton.frame) != CGRect.zero
                }

                describe("point inside") {
                    var headerCenterPoint: CGPoint!
                    var buyButtonPoint: CGPoint!
                    var backButtonPoint: CGPoint!

                    beforeEach {
                        headerCenterPoint = CGPoint(x: sut.frame.width * 0.5, y: sut.frame.height * 0.5)
                        buyButtonPoint = CGPoint(x: sut.buyButton.frame.maxX - 1, y: sut.buyButton.frame.maxY - 1)
                        backButtonPoint = CGPoint(x: sut.backButton.frame.maxX - 5, y: sut.backButton.frame.maxY - 5)
                    }

                    afterEach {
                        headerCenterPoint = nil
                        buyButtonPoint = nil
                        backButtonPoint = nil
                    }

                    it("should report header center is NOT inside a view") {
                        expect(sut.point(inside: headerCenterPoint, with: nil)) == false
                    }

                    it("should report buy button is inside a view") {
                        expect(sut.point(inside: buyButtonPoint, with: nil)) == true
                    }

                    it("should report back button is inside a view") {
                        expect(sut.point(inside: backButtonPoint, with: nil)) == true
                    }
                }
            }
        }
    }

}
