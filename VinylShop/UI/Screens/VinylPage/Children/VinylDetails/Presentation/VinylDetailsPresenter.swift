class VinylDetailsPresenter {

    func present(side: Side, in cell: VinylSideCell) {
        cell.titleLabel.text = "Side \(side.name)"
    }

    func present(track: Track, in cell: VinylTrackCell) {
        cell.positionLabel.text = track.position
        cell.nameLabel.text = track.name
        cell.durationLabel.text = track.duration
    }

}
