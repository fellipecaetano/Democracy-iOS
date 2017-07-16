func PoliticiansReducer(state: PoliticiansState, action: Action) -> PoliticiansState {
    switch action {
    case PoliticiansAction.startLoading:
        return PoliticiansState(data: state.data, isLoading: true, error: nil)
    case PoliticiansAction.load(let data):
        return PoliticiansState(data: data, isLoading: false, error: nil)
    case PoliticiansAction.fail(let error):
        return PoliticiansState(data: state.data, isLoading: false, error: error)
    default:
        return state
    }
}
