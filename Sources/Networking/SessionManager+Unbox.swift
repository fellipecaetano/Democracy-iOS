import Alamofire
import RxSwift
import Unbox

extension Reactive where Base == SessionManager {
    func value<T: Unboxable>(request: Request<T>) -> Observable<T> {
        return data(request: request).map(unbox(data:))
    }

    func value<T: Unboxable>(request: Request<T>) -> Observable<[T]> {
        return data(request: request).map({ data in
            return try unbox(data: data) as [T]
        })
    }
}
