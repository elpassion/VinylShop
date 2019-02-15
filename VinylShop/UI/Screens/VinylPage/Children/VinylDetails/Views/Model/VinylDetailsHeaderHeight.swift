import CoreGraphics

struct VinylDetailsHeaderHeight {
    let original: CGFloat
    let current: CGFloat
    let minimal: CGFloat

    init?(original: CGFloat, current: CGFloat, minimal: CGFloat) {
        guard original > 0.0, current > 0.0, minimal > 0.0, original > minimal, current >= minimal else {
            return nil
        }

        self.original = original
        self.current = current
        self.minimal = minimal
    }
}

extension VinylDetailsHeaderHeight {

    var scale: CGFloat {
        return current / original
    }

    var scrollProgress: CGFloat {
        return (current - minimal) / (original - minimal)
    }

}
