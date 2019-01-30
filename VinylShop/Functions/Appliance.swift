precedencegroup ForwardAppliance {
    associativity: left
    higherThan: AssignmentPrecedence
}

infix operator |>: ForwardAppliance

func |><A: AnyObject>(_ value: A, f: @escaping (A) -> Void) -> A {
    f(value)
    return value
}
