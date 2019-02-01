import UIKit

protocol ShoppingBarControllerProtocol {
    var barControl: UIControl { get }
}

typealias ShoppingBarControlling = UIViewController & ShoppingBarControllerProtocol
