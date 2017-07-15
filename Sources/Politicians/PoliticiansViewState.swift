enum PoliticiansViewState {
    case loading
    case failed
    case loaded
    case empty
}

struct PoliticiansViewStateFactory {
    static func viewState(for state: PoliticiansState) -> PoliticiansViewState {
        if state.error != nil {
            return .failed
        } else if state.isLoading {
            return .loading
        } else if state.data.isEmpty {
            return .empty
        } else {
            return .loaded
        }
    }
}
