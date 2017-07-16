func AppReducer(state: AppState, action: Action) -> AppState {
    return AppState(
        politicians: PoliticiansReducer(state: state.politicians, action: action),
        followedPoliticians: FollowedPoliticiansReducer(state: state.followedPoliticians, action: action)
    )
}
