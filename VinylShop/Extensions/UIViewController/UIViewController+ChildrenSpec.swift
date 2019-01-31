@testable import VinylShop
import Nimble
import Quick

class UIViewController_ChildrenSpec: QuickSpec {

    override func spec() {
        describe("UIViewController+Children") {
            var embeddedController: UIViewController!
            var sut: UIViewController!

            beforeEach {
                embeddedController = UIViewController(nibName: nil, bundle: nil)
                sut = UIViewController(nibName: nil, bundle: nil)
            }

            afterEach {
                embeddedController = nil
                sut = nil
            }

            context("when embedding controller with no target view") {
                beforeEach {
                    sut.embed(childViewController: embeddedController)
                }

                it("should add embedded controller view to controller's main view subviews") {
                    expect(sut.view.subviews).to(contain(embeddedController.view))
                }

                it("should add embedded controller to sut children") {
                    expect(sut.children).to(contain(embeddedController))
                }
            }

            context("when embedding controller with target view") {
                var targetView: UIView!

                beforeEach {
                    targetView = UIView(frame: .zero)
                    sut.view.addSubview(targetView)
                    sut.embed(childViewController: embeddedController, inside: targetView)
                }

                afterEach {
                    targetView = nil
                }

                it("should add embedded controller view to target subviews") {
                    expect(sut.view.subviews).toNot(contain(embeddedController.view))
                    expect(targetView.subviews).to(contain(embeddedController.view))
                }

                it("should add embedded controller to sut children") {
                    expect(sut.children).to(contain(embeddedController))
                }
            }
        }
    }

}
