typealias Middleware<S: StoreProtocol> = (S) -> (Action) -> Void

struct Middlewares {
    static func combine<S>(_ middleware: Middleware<S>...) -> Middleware<S> {
        return { store in
            return { action in middleware.forEach({ $0(store)(action) }) }
        }
    }
}
