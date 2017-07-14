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

func compose<T>(_ fns: [(T) -> T]) -> (T) -> T {
    return { t in
        fns.reversed().reduce(t, { v, f in f(v) })
    }
}

func map<T, U>(_ fn: @escaping (T) -> U) -> ([T]) -> [U] {
    return { array in
        array.map(fn)
    }
}
