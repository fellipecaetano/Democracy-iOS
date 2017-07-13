func not<T>(_ fn: @escaping (T) -> Bool) -> (T) -> Bool {
    return { t in
        return !fn(t)
    }
}

func pipe<T, U, V>(_ a: @escaping (T) -> U, _ b: @escaping (U) -> V) -> (T) -> V {
    return { t in
        return b(a(t))
    }
}
