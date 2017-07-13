import RxSwift
import Alamofire

func LoadPoliticiansEpic(actions: Observable<Action>) -> Observable<Action> {
    let sessionManager = SessionManager()
    return LoadPoliticiansEpic(actions: actions, values: sessionManager.rx.value(request:))
}

func LoadPoliticiansEpic(actions: Observable<Action>,
                         values: @escaping (Request<[Politician]>) -> Observable<[Politician]>) -> Observable<Action> {
    return actions
        .map(RequestFactory.request(forAction:))
        .unwrap()
        .flatMap(values)
        .map(PoliticiansAction.load)
        .catchError(pipe(PoliticiansAction.fail, Observable.just(_:)))
}

private final class RequestFactory {
    static func request(forAction action: Action) -> Request<[Politician]>? {
        switch action {
        case PoliticiansAction.startLoading:
            return Request<[Politician]>(
                url: URL(string: "http://localhost:9000/politicians")!,
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
