typealias Middleware<State> = (() -> State, Dispatch) -> (Dispatch) -> Dispatch

struct MiddlewareUtils {
    func combine<State>(_ middleware: Middleware<State>...) -> Middleware<State> {
        fatalError()
    }
}
