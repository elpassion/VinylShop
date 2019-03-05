@testable import VinylShop
import Nimble
import Quick

class ForceCastSpec: QuickSpec {

    override func spec() {
        describe("ForceCast") {
            var textField: UIView!

            beforeEach {
                textField = UITextField(frame: .zero)
            }

            afterEach {
                textField = nil
            }

            describe("to related type") {
                it("should return the same casted value") {
                    expect(forceCast(textField) as UITextField) === textField
                }
            }

            describe("to unrelated type") {
                it("should crash") {
                    expect { _ = forceCast(textField) as UILabel }.to(throwAssertion())
                }
            }
        }
    }

}
