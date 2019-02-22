struct ShopDetails: Decodable {
    let vinyls: [Vinyl]
    let newIDs: [Int]
    let genres: [Genre]
    let recommendedIDs: [Int]
}
