infix operator <>

func <><A: AnyObject>(_ f: @escaping (A) -> Void, _ g: @escaping (A) -> Void) -> (A) -> Void {
    return { object in
        f(object)
        g(object)
    }
}
