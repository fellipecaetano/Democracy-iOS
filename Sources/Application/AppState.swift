struct AppState {
    let politicians: PoliticiansState
    let followedPoliticians: [Politician]
    static let initial = AppState(politicians: .initial, followedPoliticians: [])
}
