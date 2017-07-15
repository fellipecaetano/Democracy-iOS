import Foundation
import Unbox

struct Politician: Unboxable, Equatable {
    let name: String
    let photoUrl: URL
    let partyAcronym: String
    let federativeUnit: String

    init(unboxer: Unboxer) throws {
        name = try unboxer.unbox(key: "name")
        photoUrl = try unboxer.unbox(key: "photoUrl")
        partyAcronym = try unboxer.unbox(key: "partyAcronym")
        federativeUnit = try unboxer.unbox(key: "federativeUnit")
    }

    static func == (lhs: Politician, rhs: Politician) -> Bool {
        return lhs.name == rhs.name
            && lhs.photoUrl == rhs.photoUrl
            && lhs.partyAcronym == rhs.partyAcronym
            && lhs.federativeUnit == rhs.federativeUnit
    }
}
