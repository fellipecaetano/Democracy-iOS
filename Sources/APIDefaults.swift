import Foundation

struct APIDefaults {
    private static let baseURL = URL(string: "http://localhost:9000")!

    static func enhanceRequest<T>(_ request: Request<T>) -> Request<T> {
        guard var components = URLComponents(url: request.url, resolvingAgainstBaseURL: true) else {
            fatalError("Attempt to enhance malformed Request: \(request)")
        }

        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.port = baseURL.port

        return Request<T>(
            url: components.url!,
            method: request.method,
            parameters: request.parameters,
            headers: request.headers,
            parameterEncoding: request.parameterEncoding
        )
    }
}
