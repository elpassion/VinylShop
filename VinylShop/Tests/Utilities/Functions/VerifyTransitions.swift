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
    let progressTotal = Double(fractionComplete) * sut.duration

    sut.animateTransition(using: context)

    sut.allAnimators.forEach { animator in
        animator.pauseAnimation()
        animator.fractionComplete = progressToPlay(in: animator, withProgressTotal: progressTotal)
    }

    assertSnapshot(
        matching: window.snapshot,
        as: .image,
        named: name,
        record: record,
        file: file,
        testName: testName,
        line: line
    )
}

private func progressToPlay(in animator: UIViewPropertyAnimator, withProgressTotal progress: Double) -> CGFloat {
    let progressToPlay = animator.duration - progress / animator.duration
    return CGFloat(max(0, min(1 - progressToPlay, 1)))
}
