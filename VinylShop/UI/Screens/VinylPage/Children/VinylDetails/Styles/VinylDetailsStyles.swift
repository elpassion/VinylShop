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

}
