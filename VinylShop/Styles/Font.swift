enum Font {
    enum Nunito: String {
        case semibold = "Nunito-SemiBold"
        case bold = "Nunito-Bold"
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
