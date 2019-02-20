import UIKit

protocol VinylCollectionControllerProtocol {
    var vinylSelectedAction: ((Vinyl) -> Void)? { get set }
}

typealias VinylCollectionControlling = UIViewController & VinylCollectionControllerProtocol
