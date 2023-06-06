
import UIKit

final class TutorAccountCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() { }
    
    func openTutorAccount(tutor: TutorData) {
        let controller: TutorAccountController = .init()
        controller.viewModel.coordinator = self
        controller.viewModel.tutorData = tutor
        controller.hidesBottomBarWhenPushed = true
        controller.navigationItem.title = tutor.name
        navigationController.pushViewController(controller, animated: true)
    }
    
    func didFinsish(){
        parentCoordinator?.childDidFinish(self)
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
