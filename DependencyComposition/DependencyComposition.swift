/*
    App start / initialization: should be in seperate object (AppController)

    - Initialize all dependencies
    - Initialize the AppDependency container with all dependencies
    - Start the root flow out of which many child flows can derive
*/

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let appDependency = AppDependency(
            dependencyA: DependencyA(),
            dependencyB: DependencyB(),
            dependencyC: DependencyC(),
            dependencyD: DependencyD(),
            dependencyE: DependencyE(),
            dependencyF: DependencyF()
        )

        let flowController = FLowController(window: UIWindow(frame: UIScreen.main.bounds), appDependency: appDependency, navigationController: UINavigationController())

        flowController.startFlow()

        return true
    }
}


/*
    FlowController

    - Someone needs to carrey the dependency container as viewcontrollers only hold dependencies they need themselves
    - "viewCOntrollerc.dependencies = appDependency" is where all the magic happens
    - Flowcontrollers have many more important roles:
    - navigation: inject a navigation block into a viewcontroller and only let viewcontroller say "I want to navigate now!"
    - describing app flows
    - coordinating the whole scene, while injecting all dependencies
*/

class FLowController {
    var window: UIWindow!
    private var appDependency: AppDependency!
    var navigationController: UINavigationController!

    init(window: UIWindow, appDependency: AppDependency, navigationController: UINavigationController) {
        self.window = window
        self.appDependency = appDependency
        self.navigationController = navigationController
    }

    func startFlow() {
        toFirstViewController()
    }

    func finishFlow() {
        navigationController.popToRootViewController(animated: true)
    }

    private func toFirstViewController() {
        let firstVc = FirstViewController()
        firstVc.dependencies = appDependency
        firstVc.onTransition = toSecondViewController
        navigationController.setViewControllers([firstVc], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    private func toSecondViewController() {
        let secondVc = SecondViewController()
        secondVc.dependencies = appDependency
        secondVc.onTransition = toThirdViewController
        navigationController.pushViewController(secondVc, animated: true)
    }

    private func toThirdViewController() {
        let thirdVc = ThirdViewController()
        thirdVc.dependencies = appDependency
        thirdVc.onTransition = finishFlow
        navigationController.pushViewController(thirdVc, animated: true)
    }
}


/*
    ViewControllers

    - Each Viewcontroller defines what they need through thier custom Dependencies typealias
    - This adds clarity, easy injeciton with a complete dependency container and ability to add any depenency later on
    - If your familiar with dependency injection, you would otherwise need to go back through the dependency chain and pass it through all objects
*/

class FirstViewController: NextButtonViewController {
    typealias Dependencies = HasDependencyA & HasDependencyC & HasDependencyE

    var dependencies: Dependencies!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "First"
        navigationItem.prompt = "I depend on: \(dependencies.dependencyA.getState()) \(dependencies.dependencyC.getState()) \(dependencies.dependencyE.getState())"
    }
}

class SecondViewController: NextButtonViewController {
    typealias Dependencies = HasDependencyB & HasDependencyD

    var dependencies: Dependencies!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "Second"
        navigationItem.prompt = "I depend on: \(dependencies.dependencyB.getState()) \(dependencies.dependencyD.getState())"
    }
}

class ThirdViewController: NextButtonViewController {
    typealias Dependencies = HasDependencyE

    var dependencies: Dependencies!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Third"
        view.backgroundColor = .gray
        navigationItem.prompt = "I depend on: \(dependencies.dependencyE.getState())"
    }
}

class NextButtonViewController: UIViewController {
    var onTransition: (() -> Void)!
    lazy var nextButton: UIBarButtonItem = { [unowned self] in
        return UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.nextButtonTapped))
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = nextButton
    }

    @objc func nextButtonTapped() {
        onTransition()
    }
}


/*
    AppDependency

    - Simple container of all dependencies
    - This entire container can be passed to a controller or viewModel
    - Through protocol composition (HasDependencyA & HasDependencyB) each component cherrypicks what they need
*/

struct AppDependency: HasDependencyA & HasDependencyB & HasDependencyC & HasDependencyD & HasDependencyE & HasDependencyF {
    let dependencyA: DependencyA
    let dependencyB: DependencyB
    let dependencyC: DependencyC
    let dependencyD: DependencyD
    let dependencyE: DependencyE
    let dependencyF: DependencyF
}


/*
    Dependencies

    - ShoppinglistService, ImageCache, UserService etc."
    - Each controller / viewModel / .. needs different dependencies
*/

protocol HasDependencyA { var dependencyA: DependencyA { get } }
struct DependencyA { func getState() -> String { return "A" } }

protocol HasDependencyB { var dependencyB: DependencyB { get } }
struct DependencyB { func getState() -> String { return "B" } }

protocol HasDependencyC { var dependencyC: DependencyC { get } }
struct DependencyC { func getState() -> String { return "C" } }

protocol HasDependencyD { var dependencyD: DependencyD { get } }
struct DependencyD { func getState() -> String { return "D" } }

protocol HasDependencyE { var dependencyE: DependencyE { get } }
struct DependencyE { func getState() -> String { return "E" } }

protocol HasDependencyF { var dependencyF: DependencyF { get } }
struct DependencyF { func getState() -> String { return "F" } }
