import RxSwift

final class AppStore: StoreProtocol, ObservableType {
    typealias E = AppState

    private let store = Store<AppState>(
        initialState: .initial,
        reducer: AppReducer,
        middleware: MiddlewareUtils.combine(
            EpicMiddleware.create(LoadPoliticiansEpic)
        )
    )

    var state: AppState {
        return store.state
    }

    func dispatch(_ action: Action) {
        store.dispatch(action)
    }

    func subscribe(_ subscription: @escaping (AppState) -> Void) -> () -> Void {
        return store.subscribe(subscription)
    }
}
