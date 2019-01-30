import UIKit

class ShoppingBoxController: UIViewController {

    var boxView: ShoppingBoxView! {
        return view as? ShoppingBoxView
    }

    override func loadView() {
        view = ShoppingBoxView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let albums = [
            Album(title: "We the generation", band: "Rudimental"),
            Album(title: "Appetite for Destruction", band: "Guns N' Roses")
        ]

        boxView.itemsView.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        albums.enumerated().forEach { (index, album) in
            let view = ShoppingBoxItemView()
            view.titleLabel.text = album.title
            view.bandLabel.text = album.band
            view.separatorView.isHidden = index == albums.count - 1

            boxView.itemsView.stackView.addArrangedSubview(view)
        }
    }
}

struct Album {
    let title: String
    let band: String
}
