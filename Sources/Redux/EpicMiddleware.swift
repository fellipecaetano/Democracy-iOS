import RxSwift

struct EpicMiddleware {
    static func create<T>(_ epic: Epic) -> Middleware<T> {
        let actionSubject = PublishSubject<Action>()

        return { action, _ in
            actionSubject.onNext(action)
        }
    }
}
