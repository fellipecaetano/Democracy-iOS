import UIKit
import RxCocoa

final class AppRouter {
    private let window = UIWindow(frame: UIScreen.main.bounds)
    private let navigationController = UINavigationController()
    private let store = AppStore()

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        showInitialViewController()
    }

    private func showInitialViewController() {
        let viewController = ViewControllerFactory.politicians()
        navigationController.pushViewController(viewController, animated: false)
    }
}

private final class ViewControllerFactory {
    static func politicians() -> PoliticiansViewController {
        let viewController = PoliticiansViewController()
        viewController.title = L10n.senators.string
        return viewController
    }
}
