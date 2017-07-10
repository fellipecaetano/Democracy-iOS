struct PoliticiansState: Equatable {
    let data: [Politician]
    let isLoading: Bool
    let error: Error?

    static let initial = PoliticiansState(data: [], isLoading: false, error: nil)

    static func == (lhs: PoliticiansState, rhs: PoliticiansState) -> Bool {
        return lhs.data == rhs.data
            && lhs.isLoading == rhs.isLoading
            && lhs.error ~= rhs.error
    }
}
