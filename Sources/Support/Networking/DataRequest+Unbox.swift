import Alamofire
import RxSwift
import Unbox

extension DataRequest {
    @discardableResult
    public func responseValue<T: Unboxable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> Self
    {
        return response(
            queue: queue,
            responseSerializer: unboxResponseSerializer(),
            completionHandler: completionHandler
        )
    }

    @discardableResult
    public func responseValue<T: Unboxable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<[T]>) -> Void)
        -> Self
    {
        return response(
            queue: queue,
            responseSerializer: unboxResponseSerializer(),
            completionHandler: completionHandler
        )
    }
}

extension Reactive where Base == DataRequest {
    func value<T: Unboxable>() -> Observable<T> {
        return Observable.create { observer in
            let request = self.base

            request.responseValue { (response: DataResponse<T>) in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }

            return Disposables.create {
                request.cancel()
            }
        }
    }

    func value<T: Unboxable>() -> Single<[T]> {
        return .create { commit in
            let request = self.base

            request.responseValue { (response: DataResponse<[T]>) in
                switch response.result {
                case .success(let value):
                    commit(.success(value))
                case .failure(let error):
                    commit(.error(error))
                }
            }

            return Disposables.create {
                request.cancel()
            }
        }
    }
}

private func unboxResponseSerializer<T: Unboxable>() -> DataResponseSerializer<T> {
    return DataResponseSerializer { request, response, data, error in
        if let error = error {
            return .failure(error)
        } else if let data = data {
            return unbox(data: data)
        } else {
            return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
        }
    }
}

private func unbox<T: Unboxable>(data: Data) -> Result<T> {
    do {
        return try .success(unbox(data: data))
    } catch let error {
        return .failure(error)
    }
}

private func unboxResponseSerializer<T: Unboxable>() -> DataResponseSerializer<[T]> {
    return DataResponseSerializer { request, response, data, error in
        if let error = error {
            return .failure(error)
        } else if let data = data {
            return unbox(data: data)
        } else {
            return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
        }
    }
}

private func unbox<T: Unboxable>(data: Data) -> Result<[T]> {
    do {
        return try .success(unbox(data: data))
    } catch let error {
        return .failure(error)
    }
}
