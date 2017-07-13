typealias Middleware<State> = (() -> State, @escaping Dispatch) -> (@escaping Dispatch) -> Dispatch

struct MiddlewareUtils {
    func combine<State>(_ middleware: Middleware<State>...) -> Middleware<State> {
        return { getState, dispatch in
            let chain = middleware.map({ middleware in middleware(getState, dispatch) })
            return compose(chain)
        }
    }
}
