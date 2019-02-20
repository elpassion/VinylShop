import UIKit

protocol VinylDetailsControllerProtocol: class {
    var goBackAction: (() -> Void)? { get set }
}

typealias VinylDetailsControlling = UIViewController & VinylDetailsControllerProtocol
