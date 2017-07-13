import RxSwift

typealias Epic = (Observable<Action>) -> Observable<Action>

struct Epics {
    static func combine(_ epics: Epic...) -> Epic {
        return { actions in
            return Observable.merge(
                epics.map({ epic in
                    epic(actions)
                })
            )
        }
    }
}
