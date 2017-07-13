import Foundation

final class Store<T> {
    typealias Reducer = (T, Action) -> T
    typealias Subscription = (T) -> Void
    typealias Unsubscribe = () -> Void

    private let reduce: Reducer
    private var state: T { didSet { publish(state) } }
    private var subscribers: [String: Subscription]

    init (reducer: @escaping Reducer, initialState: T) {
        reduce = reducer
        state = initialState
        subscribers = [:]
    }

    func subscribe(_ subscription: @escaping Subscription) -> Unsubscribe {
        let token = UUID().uuidString
        subscribers[token] = subscription
        subscription(state)

        return { [weak self] in
            self?.subscribers.removeValue(forKey: token)
        }
    }

    func dispatch(_ action: Action) {
        state = reduce(state, action)
    }

    private func publish(_ newState: T) {
        subscribers.values.forEach({ subscription in
            subscription(newState)
        })
    }
}
