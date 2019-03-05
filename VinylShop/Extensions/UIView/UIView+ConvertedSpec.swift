@testable import VinylShop
import Nimble
import Quick

class UIView_ConvertedSpec: QuickSpec {

    override func spec() {
        describe("UIView+Converted") {
            var sut: UIView!

            beforeEach {
                sut = UIView(frame: .zero)
            }

            afterEach {
                sut = nil
            }

            describe("converting view with no superview") {
                it("should throw assertion") {
                    expect { _ = sut.converted(UIView(frame: .zero)) }.to(throwAssertion())
                }
            }

            describe("converting view with superview") {
                var superview: UIView!
                var view: UIView!
                var result: CGRect!

                beforeEach {
                    superview = UIView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
                    view = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                    superview.addSubview(view)
                    sut.addSubview(superview)

                    result = sut.converted(view)
                }

                afterEach {
                    view = nil
                }

                it("should correctly convert frame") {
                    expect(result) == CGRect(x: 30, y: 30, width: 10, height: 10)
                }
            }
        }
    }

}
