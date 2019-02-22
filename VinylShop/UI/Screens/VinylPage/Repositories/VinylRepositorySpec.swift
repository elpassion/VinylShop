@testable import VinylShop
import Nimble
import Quick

class VinylRepositorySpec: QuickSpec {

    override func spec() {
        describe("VinylRepository") {
            var sut: ((Int) -> Vinyl)!

            beforeEach {
                sut = resolveVinyl(details: .shotDetails)
            }

            afterEach {
                sut = nil
            }

            describe("with existing vinyl ID of 1") {
                var vinyl: Vinyl!

                beforeEach {
                    vinyl = sut(1)
                }

                afterEach {
                    vinyl = nil
                }

                it("should resolve Metallica's 'Master of Puppets'") {
                    expect(vinyl.title) == "Master of Puppets"
                    expect(vinyl.band) == "Metallica"
                }
            }

            describe("with non-existing vinyl ID of 666") {
                it("should crash") {
                    expect { _ = sut(666) }.to(throwAssertion())
                }
            }
        }
    }

}
