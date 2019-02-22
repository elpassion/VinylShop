import UIKit

func forceCast<Casted>(_ value: Any) -> Casted {
    guard let castedValue = value as? Casted else {
        fatalError("Expected to have a value of class \(Casted.self), got \(type(of: value)) instead")
    }

    return castedValue
}
