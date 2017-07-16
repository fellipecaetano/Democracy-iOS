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
    static func viewModel(state: Observable<PoliticiansState>) -> PoliticiansViewModel {
        return PoliticiansViewModel { input in
            PoliticiansViewModel.Output(
                items: state
                    .map({ $0.data })
                    .map(map(PoliticianItemFactory.item))
                    .asDriver(onErrorDriveWith: .empty()),

                actions: Observable.just(PoliticiansAction.startLoading)
                    .asDriver(onErrorDriveWith: .empty()),

                viewState: state
                    .map(PoliticiansViewStateFactory.viewState)
                    .asDriver(onErrorJustReturn: .failed)
            )
        }
    }
}
