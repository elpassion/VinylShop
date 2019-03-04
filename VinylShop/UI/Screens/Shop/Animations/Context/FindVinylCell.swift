func findVinylCell(forVinylID vinylID: Int, in controller: ShopController) -> VinylCollectionCell? {
    return [controller.newController, controller.recommendedController]
        .compactMap { $0 as? VinylCollectionController }
        .compactMap { $0.visibleCell(forVinylID: vinylID) }
        .first
}
