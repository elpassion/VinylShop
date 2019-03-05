import Foundation

extension ShopDetails {

    static var shotDetails: ShopDetails {
        return readShotDetails(file: "shot_details")
    }

    static func readShotDetails(file: String ) -> ShopDetails {
        guard let url = Bundle.main.url(forResource: file, withExtension: "json"),
              let shotDetails = try? JSONDecoder().decode(ShopDetails.self, from: Data(contentsOf: url)) else {
            fatalError("Could not open contents of shot_details.json file!")
        }

        return shotDetails
    }

}
