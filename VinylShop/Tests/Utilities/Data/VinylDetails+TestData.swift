@testable import VinylShop

extension VinylDetails {

    static var testDetails: VinylDetails {
        let sides = [
            Side(name: "1", tracks: [
                Track(position: "1", name: "Overture", duration: "3:34"),
                Track(position: "2", name: "A Good Part", duration: "3:47"),
                Track(position: "3", name: "Weak", duration: "3:21"),
                Track(position: "4", name: "Sober Up", duration: "3:38")
            ]),
            Side(name: "2", tracks: [
                Track(position: "5", name: "Drama", duration: "4:08"),
                Track(position: "6", name: "Turning Out", duration: "3:54"),
                Track(position: "7", name: "No Grass Today", duration: "3:39"),
                Track(position: "8", name: "Call My Dad", duration: "4:15")
            ])
        ]

        let recommended = [
            RecommendedVinyl(
                title: "Master of Puppets",
                band: "Metallica",
                image: #imageLiteral(resourceName: "cover_metallica")
            ),
            RecommendedVinyl(title: "Papaoutai", band: "Stromae", image: #imageLiteral(resourceName: "cover_stromae")),
            RecommendedVinyl(
                title: "Ghost In The Machine",
                band: "The Police",
                image: #imageLiteral(resourceName: "cover_the_police")
            )
        ]

        return VinylDetails(sides: sides, recommended: recommended)
    }

}
