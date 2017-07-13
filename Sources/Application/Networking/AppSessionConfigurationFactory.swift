import Foundation

struct AppSessionConfigurationFactory {
    static func api() -> URLSessionConfiguration {
        return .default
    }
}
