struct PoliticiansState {
    let data: [Politician]
    let isLoading: Bool
    let error: Error?

    static let initial = PoliticiansState(data: [], isLoading: false, error: nil)
}
