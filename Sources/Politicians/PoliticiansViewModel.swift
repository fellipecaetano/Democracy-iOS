import RxSwift
import RxCocoa

struct PoliticiansViewModel {
    typealias Input = Void

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
        return PoliticiansViewModel { _ in
            PoliticiansViewModel.Output(
                items: state
                    .map({ $0.data })
                    .map(map(PoliticianItemFactory.item)),

                actions: Observable<Action>
                    .just(PoliticiansAction.startLoading)
                    .asDriver(onErrorDriveWith: .empty()),

                viewState: state
                    .map(PoliticiansViewStateFactory.viewState)
                    .asDriver(onErrorRecover: pipe(PoliticiansViewState.failed, Driver.just))
            )
        }
    }
}
