precedencegroup ForwardAppliance {
    associativity: left
    higherThan: AssignmentPrecedence
}

infix operator |>: ForwardAppliance

func |><A: AnyObject>(_ value: A, first: @escaping (A) -> Void) -> A {
    first(value)
    return value
}
