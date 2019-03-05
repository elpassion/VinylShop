@testable import VinylShop
import Nimble
import Quick

class VinylTrackCellSpec: QuickSpec {

    override func spec() {
        describe("VinylTrackCell") {
            describe("required initializer") {
                it("should return nil") {
                    expect(VinylTrackCell(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
