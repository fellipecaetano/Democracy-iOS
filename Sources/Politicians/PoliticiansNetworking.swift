import Alamofire

func LoadPoliticiansRequest() -> Request<[Politician]> {
    return pipe(Request<[Politician]>.init, APIDefaults.enhanceRequest)((
        URL(string: "/politicians")!,
        .get,
        [:],
        [:],
        URLEncoding()
    ))
}
