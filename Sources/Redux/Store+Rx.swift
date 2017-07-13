import RxSwift

extension Store: ObservableType {
    typealias E = T

    func subscribe<O>(_ observer: O) -> Disposable where O : ObserverType, O.E == T {
        let unsubscribe = subscribe { state in
            observer.onNext(state)
        }

        return Disposables.create {
            unsubscribe()
        }
    }
}
