class VinylDetailsPresenter {

    func present(side: Side, in cell: VinylDetailsSideCell) {
        cell.titleLabel.text = "Side \(side.name)"
    }

}
