@testable import VinylShop
import Nimble
import Quick

class VerifyTransitionsSpec: QuickSpec {

    override func spec() {
        describe("VerifyTransitions") {
            describe("fraction completed") {
                context("when in the 0%") {
                    it("should return 0.0") {
                        expect(fractionCompleted(animationDuration: 0.4, totalDuration: 0.0)) == 0.0
                    }
                }

                context("when in the 25%") {
                    it("should return 0.25") {
                        expect(fractionCompleted(animationDuration: 0.4, totalDuration: 0.1)) == 0.25 ± 0.01
                    }
                }

                context("when in the 50%") {
                    it("should return 0.5") {
                        expect(fractionCompleted(animationDuration: 0.4, totalDuration: 0.2)) == 0.5 ± 0.01
                    }
                }

                context("when in the 75%") {
                    it("should return 0.75") {
                        expect(fractionCompleted(animationDuration: 0.4, totalDuration: 0.3)) == 0.75 ± 0.01
                    }
                }

                context("when in the 100%") {
                    it("should return 1.0") {
                        expect(fractionCompleted(animationDuration: 0.4, totalDuration: 0.4)) == 1.0
                    }
                }

                context("when in the 125%") {
                    it("should return 1.0") {
                        expect(fractionCompleted(animationDuration: 0.4, totalDuration: 0.5)) == 1.0
                    }
                }
            }
        }
    }

}
