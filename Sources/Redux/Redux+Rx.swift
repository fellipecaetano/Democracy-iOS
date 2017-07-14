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
    func connect<O: AnyObject & ReactiveCompatible>(to actions: Observable<Action>, of owner: O) {
        _ = actions.takeUntil(owner.rx.deallocated).bind(to: asObserver())
    }

    private func asObserver() -> AnyObserver<Action> {
        return AnyObserver { event in
            if case .next(let action) = event {
                self.dispatch(action)
            }
        }
    }
}
