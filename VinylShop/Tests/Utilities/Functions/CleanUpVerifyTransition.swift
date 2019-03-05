@testable import VinylShop
import UIKit

func cleanUpVerifyTransition(sut: AnimatedTransitioning) {
    sut.allAnimators.forEach { animator in
        animator.stop()
    }
}
