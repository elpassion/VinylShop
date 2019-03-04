@testable import VinylShop
import SnapshotTesting
import UIKit

func verifyTransition(sut: AnimatedTransitioning,
                      in window: UIWindow,
                      fractionComplete: CGFloat,
                      using context: UIViewControllerContextTransitioning,
                      named name: String,
                      record: Bool = false,
                      file: StaticString = #file,
                      testName: String = #function,
                      line: UInt = #line) {
    sut.animateTransition(using: context)

    let duration = Double(fractionComplete) * sut.duration

    sut.allAnimators.forEach { animator in
        animator.pauseAnimation()
        animator.fractionComplete = fractionCompleted(animationDuration: animator.duration, totalDuration: duration)
    }

    assertSnapshot(
        matching: window.snapshot,
        as: .image,
        named: "\(name)_progress_\(Int(fractionComplete * 100))",
        record: record,
        file: file,
        testName: testName,
        line: line
    )
}

func fractionCompleted(animationDuration: Double, totalDuration: Double) -> CGFloat {
    let leftToPlay = (animationDuration - totalDuration) / animationDuration
    return min(1, CGFloat(1 - leftToPlay))
}
