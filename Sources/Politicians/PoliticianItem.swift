struct PoliticianItem {
    let name: String
    let party: String
    let isFollowed: Bool
}

struct PoliticianItemFactory {
    static func item(for politician: Politician, isFollowed: Bool) -> PoliticianItem {
        return PoliticianItem(
            name: politician.name,
            party: party(of: politician),
            isFollowed: isFollowed
        )
    }
}

private func party(of politician: Politician) -> String {
    return "\(politician.partyAcronym) - \(politician.federativeUnit)"
}
