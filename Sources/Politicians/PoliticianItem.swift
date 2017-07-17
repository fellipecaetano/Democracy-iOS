struct PoliticianItem {
    let name: String
    let party: String
    let isFollowed: Bool
}

struct PoliticianItemFactory {
    static func item(for politician: Politician) -> PoliticianItem {
        return PoliticianItem(
            name: politician.name,
            party: party(of: politician),
            isFollowed: false
        )
    }
}

private func party(of politician: Politician) -> String {
    return "\(politician.partyAcronym) - \(politician.federativeUnit)"
}
