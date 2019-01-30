@testable import VinylShop
import Nimble
import Quick

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
            }
        }
    }

}
