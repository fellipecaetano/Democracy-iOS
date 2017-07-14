import RxSwift

extension StoreProtocol where Self: ObservableType, Self.State == Self.E {
    func subscribe<O: ObserverType>(_ observer: O) -> Disposable where O.E == E {
        let unsubscribe = subscribe { state in
            observer.onNext(state)
        }

        return Disposables.create {
            unsubscribe()
        }
    }
}

extension StoreProtocol {
    func asObserver() -> AnyObserver<State> {
        return AnyObserver { event in
            if case .next(let action) = event {
                self.dispatch(action)
            }
        }
    }
}
