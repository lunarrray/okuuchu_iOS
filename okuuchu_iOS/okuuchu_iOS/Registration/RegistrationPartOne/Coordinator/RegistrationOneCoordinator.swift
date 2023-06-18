
import UIKit

class RegistrationOneCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let controller: RegistrationOneController = .init()
        controller.viewModel.coordinator = self
        navigationController.viewControllers = [controller]

//        navigationController.setViewControllers([controller], animated: true)
    }
    
    func continueRegistration() {
        let registrationTwoCoordinator: RegistrationTwoCoordinator = .init(navigationController: navigationController)
        registrationTwoCoordinator.parentCoordinator = self
        childCoordinators.append(registrationTwoCoordinator)
        registrationTwoCoordinator.continueRegistration()
    }
    
    func startLogin() {
        let coordinator: LoginCoordinator = .init(navigationController: navigationController)
        coordinator.start()
    }

    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool
            in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }

}
