@testable import VinylShop
import Nimble
import Quick

class VinylDetailsNotesViewSpec: QuickSpec {

    override func spec() {
        describe("VinylDetailsNotesView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(VinylDetailsNotesView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
