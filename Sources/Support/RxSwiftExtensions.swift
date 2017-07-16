import RxSwift

extension Observable {
    func mapTo<R>(_ transform: @escaping () throws -> R) -> Observable<R> {
        return map({ _ in try transform() })
    }

    func mapTo<R>(_ value: R) -> Observable<R> {
        return map({ _ in value })
    }
}
