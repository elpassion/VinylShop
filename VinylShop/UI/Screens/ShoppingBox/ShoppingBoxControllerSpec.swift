@testable import VinylShop
import Anchorage
import Nimble
import Quick
import SnapshotTesting
import UIKit

class ShoppingBoxControllerSpec: QuickSpec {

    override func spec() {
        describe("ShoppingBoxController") {
            var sut: ShoppingBoxController!

            beforeEach {
                sut = ShoppingBoxController()
            }

            afterEach {
                sut = nil
            }

            describe("view did load") {
                beforeEach {
                    _ = sut.view
                }

                it("should have tap gesture recognizer attached to dimmed background view") {
                    expect(sut.boxView.dimmedBackgroundView.gestureRecognizers).to(contain(sut.boxView.tapGestureRecognizer))
                }

                describe("items view") {
                    var items: [ShoppingBoxItemView]!

                    beforeEach {
                        items = sut.boxView.itemsView.stackView.arrangedSubviews.compactMap { $0 as? ShoppingBoxItemView }
                    }

                    afterEach {
                        items = nil
                    }

                    it("should have 2 elements") {
                        expect(items).to(haveCount(2))
                    }

                    describe("1st item view") {
                        it("should have correct title") {
                            expect(items.first?.titleLabel.text) == "We the generation"
                        }

                        it("should have correct band") {
                            expect(items.first?.bandLabel.text) == "Rudimental"
                        }

                        it("should have visible separator") {
                            expect(items.first?.separatorView.isHidden) == false
                        }
                    }

                    describe("2nd item view") {
                        it("should have correct title") {
                            expect(items.last?.titleLabel.text) == "Appetite for Destruction"
                        }

                        it("should have correct band") {
                            expect(items.last?.bandLabel.text) == "Guns N' Roses"
                        }

                        it("should have hidden separator") {
                            expect(items.last?.separatorView.isHidden) == true
                        }
                    }
                }
            }

            context("embedded in other controller") {
                var parent: UIViewController!

                beforeEach {
                    parent = UIViewController()
                    parent.view.backgroundColor = .white

                    parent.embed(childViewController: sut)
                }

                afterEach {
                    parent = nil
                }

                it("should match snapshot on iPhone SE") {
                    assertSnapshot(matching: parent, as: .image(on: .iPhoneSe))
                }

                it("should match snapshot on iPhone 8") {
                    assertSnapshot(matching: parent, as: .image(on: .iPhone8))
                }

                it("should match snapshot on iPhone 8 Plus") {
                    assertSnapshot(matching: parent, as: .image(on: .iPhone8Plus))
                }

                it("should match snapshot on iPhone X") {
                    assertSnapshot(matching: parent, as: .image(on: .iPhoneX))
                }

                it("should match snapshot on iPhone Xs Max") {
                    assertSnapshot(matching: parent, as: .image(on: .iPhoneXsMax))
                }
            }
        }
    }

}
