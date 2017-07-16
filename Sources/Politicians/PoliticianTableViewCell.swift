import UIKit
import Cartography
import RxCocoa
import RxSwift

class PoliticianTableViewCell: UITableViewCell, Reusable {
    static let preferredHeight = Dimensions.preferredHeight

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

    fileprivate let followButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.follow.string, for: .normal)
        return button
    }()

    private(set) var disposeBag = DisposeBag()

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
        contentView.addSubview(followButton)
        createConstraints()
    }

    private func createConstraints() {
        constrainIdentificationView()
        constrainFollowButton()
    }

    private func constrainIdentificationView() {
        constrain(identificationView) { identificationView in
            identificationView.left == identificationView.superview!.left + Dimensions.identificationInsets.left
            identificationView.top == identificationView.superview!.top + Dimensions.identificationInsets.top
            identificationView.bottom == identificationView.superview!.bottom - Dimensions.identificationInsets.bottom
        }
    }

    private func constrainFollowButton() {
        constrain(followButton, identificationView) { followButton, identificationView in
            followButton.left == identificationView.right + Dimensions.identificationInsets.left
            followButton.right == followButton.superview!.right - Dimensions.followButtonMargin
            followButton.centerY == followButton.superview!.centerY
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
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

private struct Dimensions {
    static let identificationInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 8)
    static let followButtonMargin: CGFloat = 16
    static let preferredHeight: CGFloat = 64
}

extension Reactive where Base == PoliticianTableViewCell {
    var followButtonTap: ControlEvent<Void> {
        return base.followButton.rx.tap
    }
}
