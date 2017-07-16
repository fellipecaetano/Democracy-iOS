import UIKit
import RxSwift

final class PoliticiansViewController: UIViewController {
    fileprivate let actionsSubject = PublishSubject<Action>()
    fileprivate let followedIndexSubject = PublishSubject<Int>()
    private let viewModel: PoliticiansViewModel
    private let disposeBag = DisposeBag()

    var smartView: PoliticiansView! {
        return view as? PoliticiansView
    }

    var tableView: UITableView {
        return smartView.tableView
    }

    init(viewModel: PoliticiansViewModel) {
        self.viewModel = viewModel
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
        let bindings = viewModel.transform(
            PoliticiansViewModel.Input(
                followedIndex: followedIndexSubject.asObservable()
            )
        )

        bindings
            .actions
            .drive(actionsSubject)
            .disposed(by: disposeBag)

        bindings
            .items
            .drive(tableView.rx.items(ofType: PoliticianTableViewCell.self)) { [unowned self] index, item, cell in
                self.configureCell(cell, at: index, with: item)
            }
            .disposed(by: disposeBag)

        bindings
            .viewState
            .drive(smartView.rx.state)
            .disposed(by: disposeBag)
    }

    private func configureCell(_ cell: PoliticianTableViewCell, at index: Int, with item: PoliticianItem) {
        cell.render(item: item)
        cell.rx.followButtonTap.asObservable().mapTo(index).bind(to: followedIndexSubject).disposed(by: cell.disposeBag)
    }
}

extension Reactive where Base == PoliticiansViewController {
    var actions: Observable<Action> {
        return base.actionsSubject.asObservable()
    }
}
