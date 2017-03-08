import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureAppearance()
        return true
    }
}

extension AppDelegate {
    func configureAppearance() {
        UITableViewCell.appearance().backgroundColor = UIColor(red: 0.98, green: 0.97, blue: 0.93, alpha: 1.0)
    }
}
