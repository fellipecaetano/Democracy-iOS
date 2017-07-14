struct PoliticianItem {
    let title: String
    let detail: String
}

struct PoliticianItemFactory {
    static func item(for politician: Politician) -> PoliticianItem {
        return PoliticianItem(
            title: politician.name,
            detail: detail(for: politician)
        )
    }
}

private func detail(for politician: Politician) -> String {
    return "\(politician.partyAcronym) - \(politician.federativeUnit)"
}
