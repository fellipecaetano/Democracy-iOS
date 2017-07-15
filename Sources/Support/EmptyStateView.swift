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

    private let contentView = UIView()

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
        setUpContentView()
        addSubview(contentView)
        createConstraints()
    }

    private func setUpIconImageView() {
        iconImageView.image = icon
    }

    private func setUpMessageLabel() {
        messageLabel.text = message
    }

    private func setUpContentView() {
        contentView.addSubview(messageLabel)
        contentView.addSubview(iconImageView)
    }

    private func createConstraints() {
        constrainIconImageView()
        constrainMessageLabel()
        constrainContentView()
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
            messageLabel.top == iconImageView.bottom + Dimensions.iconMargin
        }
    }

    private func constrainContentView() {
        constrain(contentView) { contentView in
            contentView.width == Dimensions.width
            contentView.center == contentView.superview!.center
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

private struct Dimensions {
    static let width: CGFloat = 240
    static let iconMargin: CGFloat = 16
}
