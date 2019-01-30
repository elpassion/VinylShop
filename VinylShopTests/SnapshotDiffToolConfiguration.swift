import Quick
import SnapshotTesting

class SnapshotDiffToolConfiguration: QuickConfiguration {

    override class func configure(_ configuration: Configuration) {
        configuration.beforeEach {
            diffTool = "ksdiff"
        }
    }

}
