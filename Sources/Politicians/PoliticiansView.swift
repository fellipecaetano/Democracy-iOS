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

    fileprivate let noDataView = EmptyStateView(icon: Asset.warningIcon.image, message: L10n.noDataToShow.string)
    fileprivate let errorView = EmptyStateView(icon: Asset.errorIcon.image, message: L10n.somethingIsWrong.string)

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
        tableView.backgroundView = noDataView
    }

    private func renderWhenFailed() {
        tableView.backgroundView = errorView
    }

    private func renderWhenLoading() {
        tableView.backgroundView = nil
    }

    private func renderWhenLoaded() {
        tableView.backgroundView = nil
    }
}
