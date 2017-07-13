import RxSwift

struct EpicMiddleware {
    static func create<State>(_ epic: @escaping Epic) -> Middleware<State> {
        let actionSubject = PublishSubject<Action>()

        return { _, dispatch in
            _ = epic(actionSubject.asObservable()).subscribe(onNext: dispatch)

            return { next in
                return { action in
                    next(action)
                    actionSubject.onNext(action)
                }
            }
        }
    }
}
