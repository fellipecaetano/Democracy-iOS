enum PoliticiansAction: Action {
    case startLoading
    case load([Politician])
    case fail(Error)
}
