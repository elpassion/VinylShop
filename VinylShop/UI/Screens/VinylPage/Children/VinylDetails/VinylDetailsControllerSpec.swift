@testable import VinylShop
import Nimble
import Quick
import SnapshotTesting
import UIKit

class VinylDetailsControllerSpec: QuickSpec {

    override func spec() {
        describe("VinylDetailsController") {
            var sut: VinylDetailsController!

            beforeEach {
                let sides = [
                    Side(name: "1", tracks: [
                        Track(position: "1", name: "Overture", duration: "3:34"),
                        Track(position: "2", name: "A Good Part", duration: "3:47"),
                        Track(position: "3", name: "Weak", duration: "3:21"),
                        Track(position: "4", name: "Sober Up", duration: "3:38")
                    ]),
                    Side(name: "2", tracks: [
                        Track(position: "5", name: "Drama", duration: "4:08"),
                        Track(position: "6", name: "Turning Out", duration: "3:54"),
                        Track(position: "7", name: "No Grass Today", duration: "3:39"),
                        Track(position: "8", name: "Call My Dad", duration: "4:15")
                    ])
                ]

                sut = VinylDetailsController(vinyl: VinylDetails(sides: sides))

                record = true
            }

            afterEach {
                record = false
                sut = nil
            }

            describe("view did load") {
                beforeEach {
                    _ = sut.view
                }

                it("should embed track list controller") {
                    expect(sut.children).to(containElementSatisfying({ $0 is VinylTrackListController }))
                    expect(sut.detailsView.scrollContentView.arrangedSubviews).to(containElementSatisfying({ $0 is VinylTrackListView }))
                }
            }

            it("should match snapshot on iPhone SE") {
                assertSnapshot(matching: sut, as: .image(on: .iPhoneSe))
            }

            it("should match snapshot on iPhone 8") {
                assertSnapshot(matching: sut, as: .image(on: .iPhone8))
            }

            it("should match snapshot on iPhone 8 Plus") {
                assertSnapshot(matching: sut, as: .image(on: .iPhone8Plus))
            }

            it("should match snapshot on iPhone X") {
                assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
            }

            it("should match snapshot on iPhone Xs Max") {
                assertSnapshot(matching: sut, as: .image(on: .iPhoneXsMax))
            }
        }
    }

}
