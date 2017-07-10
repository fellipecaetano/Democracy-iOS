import RandomKit
import Fakery
@testable import Democracy

final class TestData {
    fileprivate static var randomGenerator = Xoroshiro.default
    fileprivate static var fakeDataGenerator = Faker()
}

extension TestData {
    static func error() -> Error {
        let domain = String.random(using: &randomGenerator)
        let code = Int.random(using: &randomGenerator)
        return NSError(domain: domain, code: code, userInfo: nil)
    }

    static func politicians(count: Int) -> [Politician] {
        return Array(
            Generator(count: count) {
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
