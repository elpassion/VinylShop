struct VinylDetails: Decodable {
    let sides: [Side]
    let recommended: [Vinyl]
    let new: [Vinyl]
    let genres: [Genre]
}
