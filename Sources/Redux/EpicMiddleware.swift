import RxSwift

struct EpicMiddleware {
    static func create<S: StoreProtocol>(_ epic: @escaping Epic) -> Middleware<S> {
        let actionSubject = PublishSubject<Action>()

        return { store in
            _ = epic(actionSubject.asObservable()).subscribe(onNext: { [weak store] action in
                store?.dispatch(action)
            })

            return { action in
                actionSubject.onNext(action)
            }
        }
    }
}
