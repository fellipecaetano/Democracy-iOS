import UIKit
import Cartography

public final class CounterPanelView: UIView {
    public let incrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("(+) Increment", for: .normal)
        return button
    }()

    public let decrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("(-) Decrement", for: .normal)
        return button
    }()

    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 64))
        setUp()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        backgroundColor = .white
        addSubview(incrementButton)
        addSubview(decrementButton)
        setNeedsLayout()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        incrementButton.frame = CGRect(x: 32, y: 16, width: 128, height: 32)
        decrementButton.frame = CGRect(x: 160, y: 16, width: 128, height: 32)
    }
}
