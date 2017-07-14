import UIKit
import Cartography

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
