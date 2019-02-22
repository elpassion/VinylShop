precedencegroup SameTypeComposition {
    associativity: left
    higherThan: ForwardAppliance
}

infix operator <>: SameTypeComposition

func <><A: AnyObject>(_ first: @escaping (A) -> Void, _ second: @escaping (A) -> Void) -> (A) -> Void {
    return { object in
        first(object)
        second(object)
    }
}
