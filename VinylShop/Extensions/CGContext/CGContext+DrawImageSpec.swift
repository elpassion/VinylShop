@testable import VinylShop
import Nimble
import Quick

class CGContext_DrawImageSpec: QuickSpec {

    override func spec() {
        describe("CGContext+DrawImage") {
            context("when drawing an image") {
                var currentCallIndex: Int = 0
                var beginContextCalled: (index: Int, size: CGSize, opaque: Bool, scale: CGFloat)?
                var endContextCalledAtIndex: Int?
                var getContextCalledAtIndex: Int?
                var resultingImage: UIImage?

                beforeEach {
                    currentCallIndex = 0

                    evaluateBeginImageContext = { size, opaque, scale in
                        beginContextCalled = (index: currentCallIndex, size: size, opaque: opaque, scale: scale)
                        currentCallIndex += 1
                    }

                    evaluateEndImageContext = {
                        endContextCalledAtIndex = currentCallIndex
                        currentCallIndex += 1
                    }
                }

                afterEach {
                    CGContext.resetGlobals()

                    beginContextCalled = nil
                    endContextCalledAtIndex = nil
                    getContextCalledAtIndex = nil
                    resultingImage = nil
                }

                context("when current context returns nil") {
                    beforeEach {
                        evaluateGetCurrentContext = {
                            getContextCalledAtIndex = currentCallIndex
                            currentCallIndex += 1
                            return nil
                        }

                        resultingImage = CGContext.drawImage(of: CGSize(width: 10.0, height: 10.0)) {
                            $0.setFillColor(Color.blue2FC5D8.cg())
                            $0.fill(CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0))
                        }
                    }

                    it("should return nil") {
                        expect(resultingImage).to(beNil())
                    }

                    it("should begin current context passing size first") {
                        expect(beginContextCalled?.index) == 0
                        expect(beginContextCalled?.size) == CGSize(width: 10.0, height: 10.0)
                        expect(beginContextCalled?.opaque) == false
                        expect(beginContextCalled?.scale) == 0.0
                    }

                    it("should get current context second") {
                        expect(getContextCalledAtIndex) == 1
                    }

                    it("should end context last") {
                        expect(endContextCalledAtIndex) == 2
                    }
                }

                context("when context returns a value") {
                    var currentContext: CGContext?
                    var getImageFromContextCalledAtIndex: Int?
                    var drawingClosureCalled: (index: Int, context: CGContext?)?
                    var returnedImage: UIImage?

                    beforeEach {
                        evaluateGetCurrentContext = {
                            getContextCalledAtIndex = currentCallIndex
                            currentCallIndex += 1
                            UIKit.UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
                            currentContext = UIKit.UIGraphicsGetCurrentContext()
                            return currentContext
                        }

                        evaluateGetImageFromCurrentContext = {
                            getImageFromContextCalledAtIndex = currentCallIndex
                            currentCallIndex += 1

                            return #imageLiteral(resourceName: "dismiss_box_arrow")
                        }

                        returnedImage = CGContext.drawImage(of: CGSize(width: 40.0, height: 40.0)) {
                            drawingClosureCalled = (index: currentCallIndex, context: $0)
                            currentCallIndex += 1
                        }
                    }

                    afterEach {
                        currentContext = nil
                        getImageFromContextCalledAtIndex = nil
                        drawingClosureCalled = nil
                        returnedImage = nil
                    }

                    it("should return the image from the context") {
                        expect(returnedImage).to(beImage(#imageLiteral(resourceName: "dismiss_box_arrow")))
                    }

                    it("should call begin current context passing the size first") {
                        expect(beginContextCalled?.size) == CGSize(width: 40.0, height: 40.0)
                        expect(beginContextCalled?.index) == 0
                        expect(beginContextCalled?.opaque) == false
                        expect(beginContextCalled?.scale) == 0.0
                    }

                    it("should call get current context second") {
                        expect(getContextCalledAtIndex) == 1
                    }

                    it("should call drawing closure passing current context third") {
                        expect(drawingClosureCalled?.index) == 2
                        expect(drawingClosureCalled?.context).toNot(beNil())
                        expect(drawingClosureCalled?.context) === currentContext
                    }

                    it("should call get image fourth") {
                        expect(getImageFromContextCalledAtIndex) == 3
                    }

                    it("should call end context last") {
                        expect(endContextCalledAtIndex) == 4
                    }
                }
            }
        }
    }

}
