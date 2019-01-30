@testable import VinylShop
import Nimble
import Quick
import UIKit

class ApplianceSpec: QuickSpec {

    override func spec() {
        describe("Appliance") {
            describe("forward appliance") {
                describe("applied to an object") {
                    var sut: UILabel!

                    beforeEach {
                        sut = UILabel(frame: .zero)
                            |> { $0.numberOfLines = 2 }
                            |> { $0.text = "Hello world!" }
                    }

                    afterEach {
                        sut = nil
                    }

                    it("should apply methods") {
                        expect(sut.numberOfLines) == 2
                        expect(sut.text) == "Hello world!"
                    }
                }
            }
        }
    }

}
