import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let categoryVc = CategoriesViewController()
        categoryVc.categoryViewModel = CategoryViewModel()
        window?.rootViewController = UINavigationController(rootViewController: categoryVc)

        window?.makeKeyAndVisible()

        return true
    }
}


