@testable import VinylShop
import Nimble
import Quick
import UIKit

class AppDelegateSpec: QuickSpec {

    override func spec() {
        describe("AppDelegate") {
            var sut: AppDelegate!

            beforeEach {
                sut = AppDelegate()
            }

            afterEach {
                sut = nil
            }

            describe("application did finish launching") {
                var result: Bool?

                beforeEach {
                    result = sut.application(.shared, didFinishLaunchingWithOptions: nil)
                }

                afterEach {
                    result = nil
                }

                it("should return true") {
                    expect(result) == true
                }

                describe("window") {
                    it("should NOT be nil") {
                        expect(sut.window).toNot(beNil())
                    }

                    it("should have correct size") {
                        expect(sut.window?.frame.size) == UIScreen.main.bounds.size
                    }

                    it("should be key window") {
                        expect(sut.window?.isKeyWindow) == true
                    }

                    it("should have a root view controller of VinylPageController class") {
                        expect(sut.window?.rootViewController).to(beAnInstanceOf(VinylPageController.self))
                    }
                }
            }
        }
    }

}
