import UIKit
import RxSwift

final class PoliticiansViewController: UIViewController {
    fileprivate let actionsSubject = PublishSubject<Action>()
    private let state: Observable<PoliticiansState>
    private let disposeBag = DisposeBag()

    var smartView: PoliticiansView! {
        return view as? PoliticiansView
    }

    var tableView: UITableView {
        return smartView.tableView
    }

    init(state: Observable<PoliticiansState>) {
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = PoliticiansView(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    private func bind() {
        Observable<Action>.just(PoliticiansAction.startLoading)
            .bind(to: actionsSubject)
            .disposed(by: disposeBag)

        state
            .map({ $0.data })
            .bind(to: tableView.rx.items(cellIdentifier: "PoliticianTableViewCell", cellType: UITableViewCell.self)) { index, politician, cell in
                cell.textLabel?.text = politician.name
                cell.detailTextLabel?.text = "\(politician.partyAcronym)-\(politician.federativeUnit)"
            }
            .disposed(by: disposeBag)
    }
}

extension Reactive where Base == PoliticiansViewController {
    var actions: Observable<Action> {
        return base.actionsSubject.asObservable()
    }
}
