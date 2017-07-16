func FollowedPoliticiansReducer(state: [Politician], action: Action) -> [Politician] {
    switch action {
    case FollowedPoliticiansAction.mark(let politician) where state.contains(politician):
        return state.removing(politician)
    case FollowedPoliticiansAction.mark(let politician):
        return state.appending(politician)
    default:
        return state
    }
}
