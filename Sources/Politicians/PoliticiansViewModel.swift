import RxSwift
import RxCocoa

struct PoliticiansViewModel {
    typealias Input = Void

    struct Output {
        let items: Driver<[PoliticianItem]>
        let actions: Driver<Action>
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
                items: Transforms.items(state: state)
                    .asDriver(onErrorJustReturn: []),

                actions: Observable<Action>
                    .just(PoliticiansAction.startLoading)
                    .asDriver(onErrorDriveWith: .empty())
            )
        }
    }
}

private struct Transforms {
    static func items(state: Observable<PoliticiansState>) -> Observable<[PoliticianItem]> {
        return state
            .map({ $0.data })
            .map(map(PoliticianItemFactory.item))
    }
}
