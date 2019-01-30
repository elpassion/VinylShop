@testable import VinylShop
import Anchorage
import Nimble
import Quick
import SnapshotTesting
import UIKit

class ShoppingBoxControllerSpec: QuickSpec {

    override func spec() {
        describe("ShoppingBoxController") {
            var sut: ShoppingBoxController!

            beforeEach {
                sut = ShoppingBoxController()
            }

            afterEach {
                sut = nil
            }

            context("embedded in other controller") {
                var parent: UIViewController!

                beforeEach {
                    parent = UIViewController()
                    parent.view.backgroundColor = .white

                    sut.willMove(toParent: parent)
                    parent.addChild(sut)
                    parent.view.addSubview(sut.view)
                    sut.view.edgeAnchors == parent.view.edgeAnchors

                    sut.didMove(toParent: parent)
                }

                afterEach {
                    parent = nil
                }

                it("should match snapshot on iPhone SE") {
                    assertSnapshot(matching: parent, as: .image(on: .iPhoneSe))
                }

                it("should match snapshot on iPhone 8") {
                    assertSnapshot(matching: parent, as: .image(on: .iPhone8))
                }

                it("should match snapshot on iPhone 8 Plus") {
                    assertSnapshot(matching: parent, as: .image(on: .iPhone8Plus))
                }

                it("should match snapshot on iPhone X") {
                    assertSnapshot(matching: parent, as: .image(on: .iPhoneX))
                }

                it("should match snapshot on iPhone Xs Max") {
                    assertSnapshot(matching: parent, as: .image(on: .iPhoneXsMax))
                }
            }
        }
    }

}
