
import UIKit

class TeacherProfileCoordinator: Coordinator{
    private(set) var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let teacherProfileController: TeacherProfileController = .init()
        teacherProfileController.viewModel.coordinator = self
        navigationController.viewControllers = [teacherProfileController]
    }
    
 
}
