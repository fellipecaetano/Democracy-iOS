import RandomKit
import Fakery
@testable import Democracy

final class TestData {
    fileprivate static var randomGenerator = Xoroshiro.default
    fileprivate static var fakeDataGenerator = Faker()
}

private extension TestData {
    struct Generator<T>: IteratorProtocol, Sequence {
        let _next: () -> T

        init (_ next: @escaping () -> T) {
            _next = next
        }

        mutating func next() -> T? {
            return _next()
        }
    }
}

extension TestData {
    static func error() -> Error {
        let domain = String.random(using: &randomGenerator)
        let code = Int.random(using: &randomGenerator)
        return NSError(domain: domain, code: code, userInfo: nil)
    }

    static func politicians() -> [Politician] {
        return Array(
            Generator {
                Politician(
                    name: .random(using: &randomGenerator),
                    photoUrl: URL(string: fakeDataGenerator.internet.url())!,
                    partyAcronym: .random(using: &randomGenerator),
                    federativeUnit: .random(using: &randomGenerator)
                )
            }
        )
    }
}
