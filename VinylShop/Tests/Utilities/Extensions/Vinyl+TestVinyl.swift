@testable import VinylShop

extension Vinyl {

    static var testVinyl: Vinyl {
        let title = "We the Generation"
        let details = ShopDetails.shotDetails

        guard let vinyl = details.vinyls.first(where: { $0.title == title }) else {
            fatalError("Could not find test vinyl with title: \(title)!")
        }

        return vinyl
    }

}
