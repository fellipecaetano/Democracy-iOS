import RxSwift
import RxCocoa

struct PoliticiansViewModel {
    struct Input {
        let followedIndex: Observable<Int>
    }

    struct Output {
        let items: Driver<[PoliticianItem]>
        let actions: Driver<Action>
        let viewState: Driver<PoliticiansViewState>
    }

    let transform: (Input) -> Output

    init (_ transform: @escaping (Input) -> Output) {
        self.transform = transform
    }
}

struct PoliticiansViewModelFactory {
    static func viewModel(state: Observable<PoliticiansState>,
                          followedPoliticians: Observable<[Politician]>) -> PoliticiansViewModel {
        return PoliticiansViewModel { input in
            PoliticiansViewModel.Output(
                items: Observable.combineLatest(state.distinctUntilChanged(), followedPoliticians)
                    .observeOn(ConcurrentDispatchQueueScheduler(qos: .userInteractive))
                    .map({ state, followedPoliticians in
                        state.data.map({ politician in
                            PoliticianItemFactory.item(for: politician, isFollowed: followedPoliticians.contains(politician))
                        })
                    })
                    .asDriver(onErrorDriveWith: .empty()),

                actions: Observable.combineLatest(state.distinctUntilChanged(), input.followedIndex)
                    .map({ $0.data[$1] })
                    .map(FollowedPoliticiansAction.mark)
                    .startWith(PoliticiansAction.startLoading)
                    .asDriver(onErrorDriveWith: .empty()),

                viewState: state
                    .map(PoliticiansViewStateFactory.viewState)
                    .asDriver(onErrorJustReturn: .failed)
            )
        }
    }
}
