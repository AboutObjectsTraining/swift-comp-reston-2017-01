import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.lightGray
        
        window?.rootViewController = CoolViewController()
        
        window?.makeKeyAndVisible()
    }
}

//extension AppDelegate
//{
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        let location = touch.location(in: touch.view?.superview)
//        touch.view?.center = location
//    }
//}
//
