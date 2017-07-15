enum PoliticiansViewState {
    case loading
    case failed(Error)
    case loaded([Politician])
    case empty
}

struct PoliticiansViewStateFactory {
    static func viewState(for state: PoliticiansState) -> PoliticiansViewState {
        if let error = state.error {
            return .failed(error)
        } else if state.isLoading {
            return .loading
        } else if state.data.isEmpty {
            return .empty
        } else {
            return .loaded(state.data)
        }
    }
}
