@testable import VinylShop
import Nimble
import Quick

class VinylDetailsGenreViewSpec: QuickSpec {

    override func spec() {
        describe("VinylDetailsGenreView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(VinylDetailsGenreView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
