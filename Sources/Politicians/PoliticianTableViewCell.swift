import UIKit

class PoliticianTableViewCell: UITableViewCell, Reusable {
    static let preferredHeight: CGFloat = 60

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func render(item: PoliticianItem) {
        textLabel?.text = item.title
        detailTextLabel?.text = item.detail
    }
}
