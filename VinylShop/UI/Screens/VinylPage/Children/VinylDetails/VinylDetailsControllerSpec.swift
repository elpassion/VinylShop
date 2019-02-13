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
                sut = VinylDetailsController(vinyl: .testDetails)

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

                it("should embed recommended controller") {
                    expect(sut.children).to(containElementSatisfying({ $0 is RecommendedController }))
                    expect(sut.detailsView.scrollContentView.arrangedSubviews).to(containElementSatisfying({ $0 is RecommendedView }))
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
