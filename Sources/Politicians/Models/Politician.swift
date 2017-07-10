import Foundation

struct Politician: Equatable {
    let name: String
    let photoUrl: URL
    let partyAcronym: String
    let federativeUnit: String

    static func == (lhs: Politician, rhs: Politician) -> Bool {
        return lhs.name == rhs.name
            && lhs.photoUrl == rhs.photoUrl
            && lhs.partyAcronym == rhs.partyAcronym
            && lhs.federativeUnit == rhs.federativeUnit
    }
}
