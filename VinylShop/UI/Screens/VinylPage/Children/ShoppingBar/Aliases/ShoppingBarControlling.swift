import UIKit

protocol ShoppingBarControllerProtocol {
    var barView: ShoppingBarView! { get }
}

typealias ShoppingBarControlling = UIViewController & ShoppingBarControllerProtocol
