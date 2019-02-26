import BonMot
import UIKit

var headerLayerStyle: (CAGradientLayer) -> Void =
    gradient(colors: .purple6B1A3B, .green4BC9AF)
        <> startPoint(x: 0.231_6, y: 0.857_1)
        <> endPoint(x: 0.860_2, y: -0.439_25)

var headerCoverStyle: (UIImageView) -> Void =
    image(#imageLiteral(resourceName: "album_cover"))
        <> shadow(color: .black000000, alpha: 0.5, y: 2, blur: 4)
