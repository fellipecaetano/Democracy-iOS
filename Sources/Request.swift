import Alamofire

struct Request<T> {
    let url: URL
    let method: HTTPMethod
    let parameters: Parameters
    let headers: HTTPHeaders
    let parameterEncoding: ParameterEncoding
}
