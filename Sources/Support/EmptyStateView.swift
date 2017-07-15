import UIKit
import Cartography

final class EmptyStateView: UIView {
    private let icon: UIImage
    private let message: String

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = Style.Colors.message
        label.font = Style.Fonts.message
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    init (icon: UIImage, message: String) {
        self.icon = icon
        self.message = message
        super.init(frame: .zero)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpIconImageView()
        setUpMessageLabel()
        createConstraints()
    }

    private func setUpIconImageView() {
        iconImageView.image = icon
        addSubview(iconImageView)
    }

    private func setUpMessageLabel() {
        messageLabel.text = message
        addSubview(messageLabel)
    }

    private func createConstraints() {
        constrainIconImageView()
        constrainMessageLabel()
    }

    private func constrainIconImageView() {
        constrain(iconImageView) { iconImageView in
            iconImageView.top == iconImageView.superview!.top
            iconImageView.centerX == iconImageView.superview!.centerX
        }
    }

    private func constrainMessageLabel() {
        constrain(messageLabel, iconImageView) { messageLabel, iconImageView in
            messageLabel.left == messageLabel.superview!.left
            messageLabel.right == messageLabel.superview!.right
            messageLabel.bottom == messageLabel.superview!.bottom
            messageLabel.top == iconImageView.bottom + 16
        }
    }
}

private struct Style {
    struct Colors {
        static let message = UIColor(white: 135.0/255.0, alpha: 1)
    }

    struct Fonts {
        static let message = UIFont.systemFont(ofSize: 13)
    }
}
