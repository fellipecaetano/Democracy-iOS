import RxSwift
import Alamofire

func LoadPoliticiansEpic(actions: Observable<Action>) -> Observable<Action> {
    let sessionManager = SessionManager(configuration: AppSessionConfigurationFactory.api())
    return LoadPoliticiansEpic(actions: actions, values: sessionManager.rx.value(request:))
}

func LoadPoliticiansEpic(actions: Observable<Action>,
                         values: @escaping (Request) -> Observable<[Politician]>) -> Observable<Action> {
    return actions
        .map(RequestFactory.request)
        .unwrap()
        .map(APIDefaults.enhanceRequest)
        .flatMap(values)
        .map(PoliticiansAction.load)
        .catchError(pipe(PoliticiansAction.fail, Observable.just))
}

private struct RequestFactory {
    static func request(forAction action: Action) -> Request? {
        switch action {
        case PoliticiansAction.startLoading:
            return Request(
                url: URL(string: "/politicians")!,
                method: .get,
                parameters: [:],
                headers: [:],
                parameterEncoding: URLEncoding()
            )

        default:
            return nil
        }
    }
}
