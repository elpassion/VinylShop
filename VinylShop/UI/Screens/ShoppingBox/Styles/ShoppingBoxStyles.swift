import BonMot
import UIKit

func checkoutButtonStyle() -> (UIButton) -> Void {
    return title("CHECKOUT", font: .nunito(.bold), size: 18, color: .blue2FC5D8)
        <> rounded(radius: 24)
        <> image(#imageLiteral(resourceName: "checkout_arrow"))
        <> backgroundColor(.whiteFFFFFF)
        <> flipTitleImage()
        <> insetContent(left: 20, right: 25)
        <> insetTitle(left: 16)
}

extension StringStyle {

    static var totalPriceStyle: StringStyle {
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
