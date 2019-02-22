import UIKit

func image(_ image: UIImage, mode contentMode: UIView.ContentMode = .scaleAspectFit) -> (UIImageView) -> Void {
    return { imageView in
        imageView.image = image
        imageView.contentMode = contentMode
    }
}
