@testable import VinylShop
import Nimble
import Quick

class GenresViewSpec: QuickSpec {

    override func spec() {
        describe("GenresView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(GenresView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
