@testable import VinylShop
import Nimble
import Quick

class ShopDetails_ShotDetailsSpec: QuickSpec {

    override func spec() {
        describe("ShopDetails+ShotDetails") {
            var sut: ShopDetails!

            beforeEach {
                sut = .shotDetails
            }

            afterEach {
                sut = nil
            }

            it("should have 3 genres") {
                expect(sut.genres.map { $0.name }) == ["Rock", "Metal", "Disco"]
            }

            describe("vinyls") {
                var titles: [String]!

                beforeEach {
                    titles = sut.vinyls.map { $0.title }
                }

                afterEach {
                    titles = nil
                }

                it("should have correct titles") {
                    expect(titles) == [
                        "Master of Puppets",
                        "Papaoutai",
                        "Ghost In The Machine",
                        "We the Generation",
                        "Vicious",
                        "All One Tonight - Live At The Royal Albert Hall",
                        "One Kiss",
                        "Appetite for Destruction",
                        "Dummy",
                        "Demon Days"
                    ]
                }

                it("should have non-empty sides") {
                    expect(sut.vinyls.map { $0.sides.isEmpty }).to(allPass(beFalse()))
                }

                describe("'We the Generation' vinyl") {
                    var vinyl: Vinyl?

                    beforeEach {
                        vinyl = sut.vinyls.first { $0.title == "We the Generation" }
                    }

                    afterEach {
                        vinyl = nil
                    }

                    it("should be present") {
                        expect(vinyl).toNot(beNil())
                    }

                    it("should have 2 sides") {
                        expect(vinyl?.sides).to(haveCount(2))
                    }

                    describe("1st side") {
                        var side: Side?

                        beforeEach {
                            side = vinyl?.sides[0]
                        }

                        afterEach {
                            side = nil
                        }

                        it("should have correct name") {
                            expect(side?.name) == "1"
                        }

                        it("should have tracks with correct names") {
                            expect(side?.tracks.map { $0.name }) == ["Overture", "A Good Part", "Weak", "Sober Up"]
                        }
                    }

                    describe("2nd side") {
                        var side: Side?

                        beforeEach {
                            side = vinyl?.sides[1]
                        }

                        afterEach {
                            side = nil
                        }

                        it("should have correct name") {
                            expect(side?.name) == "2"
                        }

                        it("should have tracks with correct names") {
                            expect(side?.tracks.map { $0.name }) == ["Drama", "Turning Out", "No Grass Today", "Call My Dad"]
                        }
                    }

                    it("should have correct recommended vinyls' IDs") {
                        expect(vinyl?.recommendedIDs) == [1, 2, 3]
                    }
                }
            }

            describe("recommended vinyls") {
                it("should have correct IDs") {
                    expect(sut.recommendedIDs) == [1, 2, 3]
                }
            }

            describe("new vinyls") {
                it("should have correct IDs") {
                    expect(sut.newIDs) == [4, 5, 6, 7, 8, 9, 10]
                }
            }
        }
    }

}
