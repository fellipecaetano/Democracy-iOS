import Alamofire

func LoadPoliticiansRequest() -> Request {
    return pipe(Request.init, APIDefaults.enhanceRequest)((
        URL(string: "/politicians")!,
        .get,
        [:],
        [:],
        URLEncoding()
    ))
}
