@testable import VinylShop
import Nimble
import Quick

class CompositionSpec: QuickSpec {

    override func spec() {
        describe("Composition") {
            describe("same type composition") {
                var sut: ComposedObject!

                beforeEach {
                    sut = ComposedObject()
                }

                afterEach {
                    sut = nil
                }

                describe("applied to the sut") {
                    beforeEach {
                        let composed: (ComposedObject) -> Void = { $0.replace() } <> { $0.uppercase() }
                        composed(sut)
                    }

                    it("should apply functions in correct order") {
                        expect(sut.value) == "HELLO YOU!"
                    }
                }
            }
        }
    }

}

class ComposedObject {
    var value: String = "Hello world!"

    func uppercase() {
        value = value.uppercased()
    }

    func replace() {
        value = value.replacingOccurrences(of: "world", with: "you")
    }
}
