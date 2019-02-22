import UIKit

protocol VinylDetailsControllerProtocol {
    var detailsView: VinylDetailsView { get }
    var goBackAction: (() -> Void)? { get set }
    var buyAction: (() -> Void)? { get set }
}

typealias VinylDetailsControlling = UIViewController & VinylDetailsControllerProtocol
