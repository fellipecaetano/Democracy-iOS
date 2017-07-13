typealias Middleware<T> = (Action, () -> T) -> Void
