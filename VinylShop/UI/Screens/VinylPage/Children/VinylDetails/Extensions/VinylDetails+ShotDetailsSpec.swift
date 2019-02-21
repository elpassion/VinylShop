@testable import VinylShop
import Nimble
import Quick

class VinylDetails_ShotDetailsSpec: QuickSpec {

    override func spec() {
        describe("VinylDetails+ShotDetails") {
            var sut: VinylDetails!

            beforeEach {
                sut = .shotDetails
            }

            afterEach {
                sut = nil
            }

            it("should have 2 sides") {
                expect(sut.sides).to(haveCount(2))
            }

            it("should have correct tracks on 1st side") {
                expect(sut.sides.first?.tracks.map { $0.name }) == ["Overture", "A Good Part", "Weak", "Sober Up"]
            }

            it("should have correct tracks on 2nd side") {
                expect(sut.sides.last?.tracks.map { $0.name }) == ["Drama", "Turning Out", "No Grass Today", "Call My Dad"]
            }

            it("should have 3 recommended albums") {
                expect(sut.recommended.map { $0.title }) == ["Master of Puppets", "Papaoutai", "Ghost In The Machine"]
            }

            it("should have recommended albums with correct IDs") {
                expect(sut.recommended.map { $0.id }) == [1, 2, 3]
            }

            it("should have 7 new albums") {
                expect(sut.new.map { $0.title }) == [
                    "We the Generation",
                    "Vicious",
                    "All One Tonight - Live At The Royal Albert Hall",
                    "One Kiss",
                    "Appetite for Destruction",
                    "Dummy",
                    "Demon Days"
                ]
            }

            it("should have new albums with correct IDs") {
                expect(sut.new.map { $0.id }) == [4, 5, 6, 7, 8, 9, 10]
            }

            it("should have 3 genres") {
                expect(sut.genres.map { $0.name }) == ["Rock", "Metal", "Disco"]
            }
        }
    }

}
