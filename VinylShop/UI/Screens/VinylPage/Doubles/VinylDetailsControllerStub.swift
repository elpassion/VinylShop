@testable import VinylShop
import UIKit

class VinylDetailsControllerStub: UIViewController, VinylDetailsControllerProtocol {

    // MARK: - VinylDetailsControllerProtocol

    var goBackAction: (() -> Void)?

}
