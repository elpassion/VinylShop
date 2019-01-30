enum Font {
    enum Nunito: String {
        case semiBold = "Nunito-SemiBold"
    }

    case nunito(Nunito)
}

extension Font {
    var name: String {
        switch self {
        case let .nunito(nunito):
            return nunito.rawValue
        }
    }
}
