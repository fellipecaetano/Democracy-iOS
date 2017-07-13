import RxSwift

protocol Maybe {
    associatedtype Value
    static func isEmpty(_ maybe: Self) -> Bool
    static func dematerialize(_ maybe: Self) -> Value
}

extension Optional: Maybe {
    typealias Value = Wrapped

    static func isEmpty(_ maybe: Optional<Wrapped>) -> Bool {
        return maybe == nil
    }

    static func dematerialize(_ maybe: Optional<Wrapped>) -> Wrapped {
        return maybe!
    }
}

extension Observable where E: Maybe {
    func unwrap() -> Observable<E.Value> {
        return filter(not(E.isEmpty)).map(E.dematerialize)
    }
}
