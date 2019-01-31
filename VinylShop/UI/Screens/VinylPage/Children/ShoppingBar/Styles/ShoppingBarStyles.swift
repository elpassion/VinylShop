import BonMot

extension StringStyle {

    static var albumCountStyle: StringStyle {
        let countStyle = StringStyle(.font(.from(.nunito(.extraBold), ofSize: 16)))

        return StringStyle(
            .color(Color.whiteFFFFFF.ui()),
            .font(.from(.nunito(.semibold), ofSize: 16)),
            .xmlRules([
                .style("count", countStyle)
            ])
        )
    }

    static var totalPriceSmallStyle: StringStyle {
        let priceStyle = StringStyle(.font(.from(.nunito(.extraBold), ofSize: 16)))

        return StringStyle(
            .color(Color.whiteFFFFFF.ui()),
            .font(.from(.nunito(.semibold), ofSize: 16)),
            .xmlRules([
                .style("price", priceStyle)
            ])
        )
    }

}
