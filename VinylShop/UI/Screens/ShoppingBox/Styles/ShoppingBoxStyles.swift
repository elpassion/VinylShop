import UIKit

func checkoutButtonStyle() -> (UIButton) -> Void {
    return title("CHECKOUT", font: .nunito(.bold), size: 18, color: .blue2FC5D8)
        <> rounded(radius: 24)
        <> image(#imageLiteral(resourceName: "checkout_arrow"))
        <> backgroundColor(.whiteFFFFFF)
        <> flipTitleImage()
}
