import UIKit
import Cartography
import RxSwift
import RxCocoa

final class PoliticiansView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PoliticianTableViewCell.self)
        tableView.rowHeight = PoliticianTableViewCell.preferredHeight
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        addSubview(tableView)
        createConstraints()
    }

    private func createConstraints() {
        constrainTableView()
    }

    private func constrainTableView() {
        constrain(tableView) { tableView in
            tableView.edges == tableView.superview!.edges
        }
    }
}

extension Reactive where Base: PoliticiansView {
    var state: UIBindingObserver<PoliticiansView, PoliticiansViewState> {
        return UIBindingObserver(UIElement: base) { view, state in
            view.render(state: state)
        }
    }
}

private extension PoliticiansView {
    func render(state: PoliticiansViewState) {
        switch state {
        case .empty:
            renderWhenEmpty()
        case .failed:
            renderWhenFailed()
        case .loading:
            renderWhenLoading()
        case .loaded:
            renderWhenLoaded()
        }
    }

    private func renderWhenEmpty() {
        print("empty")
    }

    private func renderWhenFailed() {
        print("failed")
    }

    private func renderWhenLoading() {
        print("loading")
    }

    private func renderWhenLoaded() {
        print("loaded")
    }
}
