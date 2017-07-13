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
}
