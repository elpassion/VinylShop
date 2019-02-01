@testable import VinylShop
import Nimble
import Quick

class EnvironmentSpec: QuickSpec {

    override func spec() {
        describe("Environment") {
            var sut: Environment!

            beforeEach {
                sut = Environment()
            }

            afterEach {
                sut = nil
            }

            describe("shared instance") {
                it("should always return the same instance") {
                    expect(Environment.shared) === Environment.shared
                }
            }
        }
    }

}
