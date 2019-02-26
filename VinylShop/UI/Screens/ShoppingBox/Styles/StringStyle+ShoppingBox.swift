import BonMot
import UIKit

extension StringStyle {

    static var totalPriceBigStyle: StringStyle {
        let currencyStyle = StringStyle(.font(.from(.nunito(.bold), ofSize: 20)), .baselineOffset(3))
        let priceStyle = StringStyle(.font(.from(.nunito(.bold), ofSize: 28)))

        return StringStyle(
            .color(Color.whiteFFFFFF.ui()),
            .font(.from(.nunito(.bold), ofSize: 10)),
            .xmlRules([
                .style("currency", currencyStyle),
                .style("price", priceStyle)
            ])
        )
    }

    static var itemPriceStyle: StringStyle {
        let currencyStyle = StringStyle(.font(.from(.nunito(.bold), ofSize: 10)), .baselineOffset(1))
        let priceStyle = StringStyle(.font(.from(.nunito(.bold), ofSize: 14)))

        return StringStyle(
            .color(Color.whiteFFFFFF.ui()),
            .font(.from(.nunito(.bold), ofSize: 8)),
            .xmlRules([
                .style("currency", currencyStyle),
                .style("price", priceStyle)
            ])
        )
    }

}
