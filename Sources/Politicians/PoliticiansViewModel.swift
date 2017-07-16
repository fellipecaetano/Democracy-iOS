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
                          scheduler: SchedulerType = MainScheduler.asyncInstance) -> PoliticiansViewModel {
        return PoliticiansViewModel { input in
            PoliticiansViewModel.Output(
                items: state
                    .map({ $0.data })
                    .map(map(PoliticianItemFactory.item))
                    .asDriver(onErrorDriveWith: .empty()),

                actions: Observable.combineLatest(state.distinctUntilChanged(),
                                                  input.followedIndex)
                    .map({ $0.data[$1] })
                    .map(FollowedPoliticiansAction.mark)
                    .startWith(PoliticiansAction.startLoading)
                    .observeOn(scheduler)
                    .asDriver(onErrorDriveWith: .empty()),

                viewState: state
                    .map(PoliticiansViewStateFactory.viewState)
                    .asDriver(onErrorJustReturn: .failed)
            )
        }
    }
}
