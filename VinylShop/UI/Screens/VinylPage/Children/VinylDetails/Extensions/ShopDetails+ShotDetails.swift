import Foundation

extension ShopDetails {

    static var shotDetails: ShopDetails {
        guard let url = Bundle.main.url(forResource: "shot_details", withExtension: "json"),
              let shotDetails = try? JSONDecoder().decode(ShopDetails.self, from: Data(contentsOf: url)) else {
            fatalError("Could not open contents of shot_details.json file!")
        }

        return shotDetails
    }

}
