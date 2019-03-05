@testable import VinylShop
import Nimble
import Quick

class GenreCellSpec: QuickSpec {

    override func spec() {
        describe("GenreCell") {
            describe("required initializer") {
                it("should return nil") {
                    expect(GenreCell(coder: NSCoder())).to(beNil())
                }
            }
        }
    }

}
