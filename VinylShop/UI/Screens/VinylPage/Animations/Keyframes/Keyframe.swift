import UIKit

struct Keyframe<Context> {
    let function: (Context) -> Void
    let start: Double
    let duration: Double

    init(play function: @escaping (Context) -> Void, from start: Double, by duration: Double) {
        self.function = function
        self.start = start
        self.duration = duration
    }
}

extension Keyframe {

    func play(with context: Context, totalDuration: Double) {
        let relativeStart = start / totalDuration
        let relativeDuration = duration / totalDuration
        let function = self.function

        UIView.addKeyframe(withRelativeStartTime: relativeStart, relativeDuration: relativeDuration) {
            function(context)
        }
    }

}
