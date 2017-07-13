import UIKit
import Alamofire
import RxAlamofire
import RxSwift
import Unbox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIViewController()
        window?.rootViewController!.view.backgroundColor = .white
        window?.makeKeyAndVisible()
        return true
    }
}
