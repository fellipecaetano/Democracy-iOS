import UIKit
import RxSwift

final class PoliticiansViewController: UIViewController {
    var smartView: PoliticiansView! {
        return view as? PoliticiansView
    }

    var tableView: UITableView {
        return smartView.tableView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
