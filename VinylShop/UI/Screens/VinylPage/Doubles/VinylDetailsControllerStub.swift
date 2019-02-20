@testable import VinylShop
import UIKit

class VinylDetailsControllerStub: UIViewController, VinylDetailsControllerProtocol {

    // MARK: - VinylDetailsControllerProtocol

    let detailsView: VinylDetailsView! = VinylDetailsView()
    var goBackAction: (() -> Void)?
    var buyAction: (() -> Void)?

}
