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

                it("should match snapshot") {
                    assertSnapshot(matching: parent, as: .image)
                }
            }
        }
    }

}
