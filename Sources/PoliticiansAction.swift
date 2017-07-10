enum PoliticiansAction {
    case startLoading
    case load([Politician])
    case fail(Error)
}
