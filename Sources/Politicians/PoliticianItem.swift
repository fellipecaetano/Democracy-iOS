struct PoliticianItem {
    let name: String
    let party: String
}

struct PoliticianItemFactory {
    static func item(for politician: Politician) -> PoliticianItem {
        return PoliticianItem(
            name: politician.name,
            party: party(of: politician)
        )
    }
}

private func party(of politician: Politician) -> String {
    return "\(politician.partyAcronym) - \(politician.federativeUnit)"
}
