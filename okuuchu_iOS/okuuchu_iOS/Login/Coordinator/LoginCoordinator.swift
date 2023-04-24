
import UIKit

class LoginCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let controller: LoginController = .init()
        controller.viewModel.coordinator = self
        navigationController.viewControllers = [controller]
        appDelegate?.window?.rootViewController = navigationController
        appDelegate?.window?.makeKeyAndVisible()
    }
    
    func openRegistrationScreen(){
        let coordinator: RegistrationCoordinator = .init(navigationController: navigationController)
        coordinator.start()
    }
    
    func openTeacherProfile(){
        var profileCoordinator: TeacherProfileCoordinator = .init(navigationController: navigationController)
        profileCoordinator.start()
    }
}


