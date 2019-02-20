@testable import VinylShop
import UIKit

class VinylCollectionControllerStub: UIViewController, VinylCollectionControllerProtocol {

    // MARK: - VinylCollectionControllerProtocol

    var vinylSelectedAction: ((Vinyl) -> Void)?

}
