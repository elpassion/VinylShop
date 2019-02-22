import BonMot
import UIKit

extension StringStyle {

    static var notesStyle: StringStyle {
        return StringStyle(
            .color(Color.black000000.ui()),
            .font(.from(.nunito(.semibold), ofSize: 14)),
            .lineSpacing(2)
        )
    }

    static var vinylPriceStyle: StringStyle {
        let currencyStyle = StringStyle(.font(.from(.nunito(.bold), ofSize: 14)), .baselineOffset(1))
        let priceStyle = StringStyle(.font(.from(.nunito(.bold), ofSize: 18)))

        return StringStyle(
            .color(Color.whiteFFFFFF.ui()),
            .font(.from(.nunito(.bold), ofSize: 10)),
            .xmlRules([
                .style("currency", currencyStyle),
                .style("price", priceStyle)
            ])
        )
    }

}

var headerLayerStyle: (CAGradientLayer) -> Void =
    gradient(colors: .purple6B1A3B, .green4BC9AF)
        <> startPoint(x: 0.231_6, y: 0.857_1)
        <> endPoint(x: 0.860_2, y: -0.439_25)

var headerCoverStyle: (UIImageView) -> Void =
    image(#imageLiteral(resourceName: "album_cover"))
        <> shadow(color: .black000000, alpha: 0.5, y: 2, blur: 4)
