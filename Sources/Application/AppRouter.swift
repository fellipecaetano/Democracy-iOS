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
        let state = store.map({ $0.politicians })
        let viewModel = PoliticiansViewModelFactory.viewModel(state: state)
        let viewController = PoliticiansViewController(viewModel: viewModel)
        store.connect(to: viewController.rx.actions, of: viewController)
        return viewController
    }
}
