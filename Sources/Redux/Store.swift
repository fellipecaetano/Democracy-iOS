import Foundation

final class Store<T>: StoreProtocol {
    typealias Reducer = (T, Action) -> T
    typealias Subscription = (T) -> Void
    typealias Unsubscribe = () -> Void

    private(set) var state: T { didSet { publish(state) } }
    private let middleware: Middleware<Store>
    private let reduce: Reducer
    private var subscribers: [String: Subscription]

    init (initialState: T, middleware: @escaping Middleware<Store>, reducer: @escaping Reducer) {
        state = initialState
        self.middleware = middleware
        reduce = reducer
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

protocol StoreProtocol: class {
    associatedtype State
    var state: State { get }
    func dispatch(_ action: Action)
}
