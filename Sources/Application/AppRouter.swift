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
        let viewController = ViewControllerFactory.politicians(store: store)
        navigationController.pushViewController(viewController, animated: false)
    }
}

private final class ViewControllerFactory {
    static func politicians(store: AppStore) -> PoliticiansViewController {
        let viewModel = PoliticiansViewModelFactory.viewModel(
            state: store.map({ $0.politicians }),
            followedPoliticians: store.map({ $0.followedPoliticians })
        )

        let viewController = PoliticiansViewController(viewModel: viewModel)
        viewController.title = L10n.senators.string

        store.connect(to: viewController.rx.actions, of: viewController)
        return viewController
    }
}
