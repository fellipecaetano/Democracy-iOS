import UIKit
import Cartography

class PoliticianTableViewCell: UITableViewCell, Reusable {
    static let preferredHeight: CGFloat = 64

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Style.Fonts.name
        label.textColor = Style.Colors.name
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let partyLabel: UILabel = {
        let label = UILabel()
        label.font = Style.Fonts.details
        label.textColor = Style.Colors.details
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let identificationView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        identificationView.addArrangedSubview(nameLabel)
        identificationView.addArrangedSubview(partyLabel)
        contentView.addSubview(identificationView)
        createConstraints()
    }

    private func createConstraints() {
        constrainIdentificationView()
    }

    private func constrainIdentificationView() {
        constrain(identificationView) { identificationView in
            identificationView.edges == inset(identificationView.superview!.edges, 16, 8)
        }
    }

    func render(item: PoliticianItem) {
        nameLabel.text = item.name
        partyLabel.text = item.party
    }
}

private struct Style {
    struct Colors {
        static let name = UIColor.darkText
        static let details = UIColor.lightGray
    }

    struct Fonts {
        static let name = UIFont.systemFont(ofSize: 17)
        static let details = UIFont.systemFont(ofSize: 12)
    }
}
