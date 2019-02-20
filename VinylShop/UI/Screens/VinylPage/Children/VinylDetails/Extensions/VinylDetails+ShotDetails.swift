extension VinylDetails {

    static var shotDetails: VinylDetails {
        let sides: [Side] = [
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

        let recommended: [Vinyl] = [.metallica, .stromae, .thePolice]
        let new: [Vinyl] = [.rudimental, .halestorm, .marillion, .harrisCalvin, .gunsNRoses, .portishead, .gorillaz]
        let genres: [Genre] = ["Rock", "Metal", "Disco"].map(Genre.init)

        return VinylDetails(sides: sides, recommended: recommended, new: new, genres: genres)
    }

}

private extension Vinyl {

    static var metallica: Vinyl {
        return Vinyl(
            title: "Master of Puppets",
            band: "Metallica",
            image: #imageLiteral(resourceName: "cover_metallica")
        )
    }

    static var stromae: Vinyl {
        return Vinyl(title: "Papaoutai", band: "Stromae", image: #imageLiteral(resourceName: "cover_stromae"))
    }

    static var thePolice: Vinyl {
        return Vinyl(
            title: "Ghost In The Machine",
            band: "The Police",
            image: #imageLiteral(resourceName: "cover_the_police")
        )
    }

    static var rudimental: Vinyl {
        return Vinyl(title: "We the Generation", band: "Rudimental", image: #imageLiteral(resourceName: "album_cover"))
    }

    static var halestorm: Vinyl {
        return Vinyl(title: "Vicious", band: "Halestorm", image: #imageLiteral(resourceName: "cover_halestorm"))
    }

    static var marillion: Vinyl {
        return Vinyl(
            title: "All One Tonight - Live At The Royal Albert Hall",
            band: "Marillion",
            image: #imageLiteral(resourceName: "cover_marillion")
        )
    }

    static var harrisCalvin: Vinyl {
        return Vinyl(
            title: "One Kiss",
            band: "Harris Calvin, Lipa Dua",
            image: #imageLiteral(resourceName: "cover_harris_calvin")
        )
    }

    static var gunsNRoses: Vinyl {
        return Vinyl(
            title: "Appetite for Destruction",
            band: "Guns N' Roses",
            image: #imageLiteral(resourceName: "cover_guns_n_roses")
        )
    }

    static var portishead: Vinyl {
        return Vinyl(title: "Dummy", band: "Portishead", image: #imageLiteral(resourceName: "cover_portishead"))
    }

    static var gorillaz: Vinyl {
        return Vinyl(title: "Demon Days", band: "Gorillaz", image: #imageLiteral(resourceName: "cover_gorillaz"))
    }

}
