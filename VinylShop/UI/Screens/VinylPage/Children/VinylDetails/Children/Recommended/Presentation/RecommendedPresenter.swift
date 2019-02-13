class RecommendedPresenter {

    func present(recommended: RecommendedVinyl, in cell: RecommendedCell) {
        cell.titleLabel.text = recommended.title
        cell.bandLabel.text = recommended.band
        cell.coverImageView.image = recommended.image
    }

}
