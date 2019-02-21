import Foundation

extension VinylDetails {

    static var shotDetails: VinylDetails {
        guard let url = Bundle.main.url(forResource: "vinyl_details", withExtension: "json"),
              let shotDetails = try? JSONDecoder().decode(VinylDetails.self, from: Data(contentsOf: url)) else {
            fatalError("Could not open contents of vinyl_details.json file!")
        }

        return shotDetails
    }

}
