func resolveVinyl(details: ShopDetails = .shotDetails) -> (Int) -> Vinyl {
    return { vinylID in
        guard let vinyl = details.vinyls.first(where: { $0.id == vinylID }) else {
            fatalError("Could not find vinyl with ID: \(vinylID) in details \(details))")
        }

        return vinyl
    }
}
