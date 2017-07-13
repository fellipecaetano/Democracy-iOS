import ReSwift
import RxSwift

extension StoreType where Self: ObservableType, Self.State == Self.E {
    func subscribe<O: ObserverType>(_ observer: O) -> Disposable where O.E == E {
        let subscriber = ClosureSubscriber<State> { state in
            observer.onNext(state)
        }

        subscribe(subscriber)

        return Disposables.create {
            self.unsubscribe(subscriber)
        }
    }
}

private final class ClosureSubscriber<T>: StoreSubscriber {
    private let subscription: (T) -> Void

    init (subscription: @escaping (T) -> Void) {
        self.subscription = subscription
    }

    func newState(state: T) {
        subscription(state)
    }
}
