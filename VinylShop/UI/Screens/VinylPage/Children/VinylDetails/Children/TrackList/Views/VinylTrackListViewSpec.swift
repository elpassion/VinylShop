@testable import VinylShop
import Nimble
import Quick

class VinylTrackListViewSpec: QuickSpec {

    override func spec() {
        describe("VinylTrackListView") {
            describe("required initializer") {
                it("should return nil") {
                    expect(VinylTrackListView(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
