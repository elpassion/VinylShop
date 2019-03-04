@testable import VinylShop
import Nimble
import Quick

class AnimatedTransitioningSpec: QuickSpec {

    override func spec() {
        describe("AnimatedTransitioning") {
            var animatorStub: AnimatorStub!
            var sut: AnimatedTransitioning!

            beforeEach {
                animatorStub = AnimatorStub()
                sut = animatorStub
            }

            afterEach {
                animatorStub = nil
                sut = nil
            }

            describe("duration") {
                context("when no animators are set") {
                    beforeEach {
                        animatorStub.stubbedAnimators = []
                        animatorStub.stubbedDuration = 1.69
                    }

                    it("should return transition duration") {
                        expect(sut.duration) == 1.69
                    }
                }

                context("when animators are set") {
                    beforeEach {
                        let animator = UIViewPropertyAnimator(duration: 1.5, curve: .easeInOut)
                        let otherAnimator = UIViewPropertyAnimator(duration: 1.75, curve: .easeInOut)

                        animatorStub.stubbedAnimators = [animator, otherAnimator]
                        animatorStub.stubbedDuration = 1.69
                    }

                    it("should return the longest animator duration") {
                        expect(sut.duration) == 1.75
                    }
                }
            }
        }
    }

}
