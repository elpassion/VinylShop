class RecommendedVinylsRepository {

    init(details: ShopDetails = .shotDetails) {
        self.details = details
    }

    // MARK: - Public API

    func recommendedVinyls(forVinylWithID vinylID: Int) -> [Vinyl] {
        let vinyl = vinylResolver(vinylID)
        let recommendedIDs = Set(vinyl.recommendedIDs)

        return details.vinyls.filter { recommendedIDs.contains($0.id) }
    }

    // MARK: - Private

    private let details: ShopDetails
    private lazy var vinylResolver: (Int) -> Vinyl = resolveVinyl(details: details)

}
