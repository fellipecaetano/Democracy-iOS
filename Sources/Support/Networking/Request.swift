import Alamofire

struct Request<T> {
    let url: URL
    let method: HTTPMethod
    let parameters: Parameters
    let headers: HTTPHeaders
    let parameterEncoding: ParameterEncoding
}

extension Request: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let request = try URLRequest(url: url, method: method, headers: headers)
        return try parameterEncoding.encode(request, with: parameters)
    }
}
