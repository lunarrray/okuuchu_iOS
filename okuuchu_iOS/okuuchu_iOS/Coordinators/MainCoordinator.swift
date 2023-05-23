
import UIKit

class MainCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = TabBarController()
        tabBarController.mainCoordinator = self
        
        if navigationController.viewControllers.isEmpty {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window?.rootViewController = tabBarController
            appDelegate?.window?.makeKeyAndVisible()
        } else {
            let lastController = navigationController.viewControllers.last
            tabBarController.modalTransitionStyle = .crossDissolve
            tabBarController.modalPresentationStyle = .overFullScreen
            lastController?.present(tabBarController, animated: true)
        }
    }
    
    func appendChildCoordinators(_ coordinators: [Coordinator]) {
        childCoordinators += coordinators
    }
}
