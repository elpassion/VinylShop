@testable import VinylShop
import Nimble
import Quick

class UIFont_ConvenienceSpec: QuickSpec {

    override func spec() {
        describe("UIFont+Convenience") {
            describe("with valid font") {
                var font: UIFont!

                beforeEach {
                    font = UIFont.from(.nunito(.bold), ofSize: 12)
                }

                afterEach {
                    font = nil
                }

                it("should open correct font") {
                    expect(font.familyName) == "Nunito"
                    expect(font.fontName) == "Nunito-Bold"
                }

                it("should set size correctly") {
                    expect(font.pointSize) == 12
                }
            }

            describe("with invalid font") {
                it("should crash") {
                    expect { _ = openFont(withName: "HEAVEN_FORBID", andSize: 33) }.to(throwAssertion())
                }
            }
        }
    }

}
