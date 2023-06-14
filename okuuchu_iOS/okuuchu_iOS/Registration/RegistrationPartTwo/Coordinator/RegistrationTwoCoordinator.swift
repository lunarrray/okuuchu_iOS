
import UIKit

class RegistrationTwoCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() { }
    
    func continueRegistration() {
        let controller: RegistrationTwoController = .init()
        controller.viewModel.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func startLogin() {
        let coordinator: LoginCoordinator = .init(navigationController: navigationController)
        coordinator.start()
    }
    
    func didFinish(){
        parentCoordinator?.childDidFinish(self)
        navigationController.dismiss(animated: true)
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
