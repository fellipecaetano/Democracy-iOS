import Foundation

final class Store<State>: StoreProtocol {
    private(set) var state: State { didSet { publish(state) }}
    private let reduce: Reducer<State>
    private var subscribers: [String: (State) -> Void]
    private var dispatcher: Dispatch!

    public init (initialState: State,
                 reducer: @escaping Reducer<State>,
                 middleware: @escaping Middleware<State>) {
        self.state = initialState
        self.reduce = reducer
        self.subscribers = [:]
        self.dispatcher = middleware({ state }, _dispatch)(_dispatch)
    }

    public func dispatch(_ action: Action) {
        dispatcher(action)
    }

    private func _dispatch(_ action: Action) {
        state = reduce(state, action)
    }

    public func subscribe(_ subscription: @escaping (State) -> Void) -> () -> Void {
        let token = UUID().uuidString
        subscribers[token] = subscription
        subscription(state)

        return { [weak self] in
            _ = self?.subscribers.removeValue(forKey: token)
        }
    }

    private func publish(_ newState: State) {
        subscribers.values.forEach { $0(newState) }
    }
}

protocol StoreProtocol {
    associatedtype State
    var state: State { get }
    func dispatch(_ action: Action)
    func subscribe(_ subscription: @escaping (State) -> Void) -> () -> Void
}
