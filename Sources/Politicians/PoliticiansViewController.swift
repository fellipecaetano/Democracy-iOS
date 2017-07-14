import UIKit
import RxSwift

final class PoliticiansViewController: UIViewController {
    fileprivate let actionsSubject = PublishSubject<Action>()
    private let state: Observable<PoliticiansState>
    private let disposeBag = DisposeBag()

    init(state: Observable<PoliticiansState>) {
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        actionsSubject.onNext(PoliticiansAction.startLoading)

        state
            .subscribe(onNext: { [unowned self] politicians in
                self.title = politicians.data.first?.name
            })
            .disposed(by: disposeBag)
    }
}

extension Reactive where Base == PoliticiansViewController {
    var actions: Observable<Action> {
        return base.actionsSubject.asObservable()
    }
}
