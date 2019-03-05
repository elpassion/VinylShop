@testable import VinylShop
import Nimble
import Quick
import UIKit

class MainTabBarControllerSpec: QuickSpec {

    override func spec() {
        describe("MainTabBarController") {
            var sut: MainTabBarController!

            beforeEach {
                sut = MainTabBarController(environment: .shared)
            }

            afterEach {
                sut = nil
            }

            describe("required initializer") {
                it("should return nil") {
                    expect(MainTabBarController(coder: NSCoder())).to(beNil())
                }
            }

            describe("view did load") {
                describe("view controllers") {
                    it("should have 5 controllers") {
                        expect(sut.viewControllers).to(haveCount(5))
                    }

                    describe("3rd controller") {
                        var controller: UIViewController?

                        beforeEach {
                            controller = sut.viewControllers?[2]
                        }

                        afterEach {
                            controller = nil
                        }

                        it("should be a navigation controller from environment") {
                            expect(controller) === Environment.shared.navigationController
                        }
                    }
                }

                describe("tabs") {
                    it("should have 5 items") {
                        expect(sut.tabBar.items).to(haveCount(5))
                    }

                    describe("1st tab") {
                        var tab: UITabBarItem?

                        beforeEach {
                            tab = sut.tabBar.items?[0]
                        }

                        afterEach {
                            tab = nil
                        }

                        it("should be disabled") {
                            expect(tab?.isEnabled) == false
                        }

                        it("should have correct title") {
                            expect(tab?.title) == "Home"
                        }

                        it("should have correct image") {
                            expect(tab?.image).to(beImage(#imageLiteral(resourceName: "tab_home")))
                        }
                    }

                    describe("2nd tab") {
                        var tab: UITabBarItem?

                        beforeEach {
                            tab = sut.tabBar.items?[1]
                        }

                        afterEach {
                            tab = nil
                        }

                        it("should be disabled") {
                            expect(tab?.isEnabled) == false
                        }

                        it("should have correct title") {
                            expect(tab?.title) == "Search"
                        }

                        it("should have correct image") {
                            expect(tab?.image).to(beImage(#imageLiteral(resourceName: "tab_search")))
                        }
                    }

                    describe("3rd tab") {
                        var tab: UITabBarItem?

                        beforeEach {
                            tab = sut.tabBar.items?[2]
                        }

                        afterEach {
                            tab = nil
                        }

                        it("should be enabled") {
                            expect(tab?.isEnabled) == true
                        }

                        it("should be selected") {
                            expect(sut.selectedIndex) == 2
                        }

                        it("should have correct title") {
                            expect(tab?.title) == "Shop"
                        }

                        it("should have correct image") {
                            expect(tab?.image).to(beImage(#imageLiteral(resourceName: "tab_shop")))
                        }

                        it("should have correct selected image") {
                            expect(tab?.selectedImage).to(beImage(#imageLiteral(resourceName: "tab_shop_selected")))
                        }
                    }

                    describe("4th tab") {
                        var tab: UITabBarItem?

                        beforeEach {
                            tab = sut.tabBar.items?[3]
                        }

                        afterEach {
                            tab = nil
                        }

                        it("should be disabled") {
                            expect(tab?.isEnabled) == false
                        }

                        it("should have correct title") {
                            expect(tab?.title) == "Collection"
                        }

                        it("should have correct image") {
                            expect(tab?.image).to(beImage(#imageLiteral(resourceName: "tab_collection")))
                        }
                    }

                    describe("5th tab") {
                        var tab: UITabBarItem?

                        beforeEach {
                            tab = sut.tabBar.items?[4]
                        }

                        afterEach {
                            tab = nil
                        }

                        it("should be disabled") {
                            expect(tab?.isEnabled) == false
                        }

                        it("should have correct title") {
                            expect(tab?.title) == "Profile"
                        }

                        it("should have correct image") {
                            expect(tab?.image).to(beImage(#imageLiteral(resourceName: "tab_profile")))
                        }
                    }
                }
            }

        }
    }

}
