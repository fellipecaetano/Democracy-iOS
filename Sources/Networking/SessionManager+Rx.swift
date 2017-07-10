import RxSwift
import Alamofire
import Unbox

extension Reactive where Base == SessionManager {
    func data<T>(request: Request<T>) -> Observable<Data> {
        return base.rx.data(request.method,
                            request.url,
                            parameters: request.parameters,
                            encoding: request.parameterEncoding,
                            headers: request.headers)
    }

    func value<T: Unboxable>(request: Request<T>) -> Observable<T> {
        return data(request: request).map(unbox(data:))
    }

    func value<T: Unboxable>(request: Request<T>) -> Observable<[T]> {
        return data(request: request).map({ data in
            return try unbox(data: data) as [T]
        })
    }
}
