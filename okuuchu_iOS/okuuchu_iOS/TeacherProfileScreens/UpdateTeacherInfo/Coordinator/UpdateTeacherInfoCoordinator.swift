
import UIKit

class UpdateTeacherInfoCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var parentCoordinator: TeacherProfileCoordinator?
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let controller: UpdateTeacherInfoController = .init()
        controller.viewModel.coordinator = self
        controller.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(controller, animated: true)
    }
    
    func didFinish(){
        parentCoordinator?.childDidFinish(self)
    }
}

