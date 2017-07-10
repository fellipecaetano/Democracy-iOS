func flip<A, B, C>(_ fn: @escaping (A, B) -> C) -> (B, A) -> C {
    return { b, a in
        return fn(a, b)
    }
}
