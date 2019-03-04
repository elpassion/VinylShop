import CoreGraphics

extension CGRect {

    func enlarged(width: CGFloat = 0.0, height: CGFloat = 0.0) -> CGRect {
        return CGRect(origin: origin, size: CGSize(width: self.width + width, height: self.height + height))
    }

}
