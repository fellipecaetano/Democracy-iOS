func curry<T, U, V>(_ fn: @escaping (T, U) -> V) -> (T) -> (U) -> V {
    return { t in { u in
        return fn(t, u)
    }}
}

func flip<T, U, V>(_ fn: @escaping (T, U) -> V) -> (U, T) -> V {
    return { u, t in
        return fn(t, u)
    }
}

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
