import Foundation

public final class Store<State> {
    private(set) var state: State { didSet { publish(state) }}
    private let reduce: Reducer<State>
    private var subscribers = [String: (State) -> Void]()

    public init (initialState: State, reducer: @escaping Reducer<State>) {
        self.state = initialState
        self.reduce = reducer
    }

    public func dispatch(_ action: Action) {
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
