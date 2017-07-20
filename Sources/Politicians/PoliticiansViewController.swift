import UIKit
import RxSwift
import Alamofire

final class PoliticiansViewController: UIViewController {
    private let state: Observable<PoliticiansState>
    private let dispatch: (Action) -> Void
    private let sessionManager = SessionManager()

    var smartView: PoliticiansView! {
        return view as? PoliticiansView
    }

    var tableView: UITableView {
        return smartView.tableView
    }

    init(state: Observable<PoliticiansState>, dispatch: @escaping (Action) -> Void) {
        self.state = state
        self.dispatch = dispatch
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

        _ = state
            .map({ $0.data })
            .map({ politicians in
                politicians.map(PoliticianItemFactory.item)
            })
            .bind(to: tableView.rx.items(cellIdentifier: PoliticianTableViewCell.reuseIdentifier, cellType: PoliticianTableViewCell.self)) { index, item, cell in
                cell.render(item: item)
            }

        _ = state
            .map(PoliticiansViewStateFactory.viewState)
            .bind(to: smartView.rx.state)

        dispatch(PoliticiansAction.startLoading)

        sessionManager
            .request(LoadPoliticiansRequest())
            .responseValue { (response: DataResponse<[Politician]>) in
                switch response.result {
                case .success(let politicians):
                    self.dispatch(
                        PoliticiansAction.load(politicians)
                    )
                case .failure(let error):
                    self.dispatch(PoliticiansAction.fail(error))
                }
            }
    }
}
