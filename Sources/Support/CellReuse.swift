import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    func register<T: UITableViewCell>(_ cellClass: T.Type) where T: Reusable {
        self.register(cellClass, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue reusable cell identified by \(T.reuseIdentifier): "
                + "cell not registered or of wrong type")
        }

        return cell
    }
}
