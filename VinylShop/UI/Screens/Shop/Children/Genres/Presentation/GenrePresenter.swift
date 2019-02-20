import UIKit

class GenrePresenter {

    func present(genre: Genre, in cell: GenreCell) {
        cell.nameLabel.text = genre.name
        cell.imageView.image = genre.image
    }

}

private extension Genre {

    var image: UIImage? {
        let imageSuffix = name.lowercased()
        return UIImage(named: "genre_\(imageSuffix)")
    }

}
