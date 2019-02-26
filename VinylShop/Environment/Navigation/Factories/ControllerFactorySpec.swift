@testable import VinylShop
import Nimble
import Quick
import UIKit

class ControllerFactorySpec: QuickSpec {

    override func spec() {
        describe("ControllerFactory") {
            var sut: ((Route) -> UIViewController)!

            beforeEach {
                sut = makeController
            }

            afterEach {
                sut = nil
            }

            describe("for .vinylPage route") {
                var controller: VinylPageController!

                beforeEach {
                    controller = sut(.vinylPage(id: 9_999)) as? VinylPageController
                }

                afterEach {
                    controller = nil
                }

                it("should create vinyl page controller passing ID") {
                    expect(controller).toNot(beNil())
                    expect(controller.vinylID) == 9_999
                }
            }
        }
    }

}
