class GenrePresenter {

    func present(genre: Genre, in cell: GenreCell) {
        cell.nameLabel.text = genre.name
    }

}
