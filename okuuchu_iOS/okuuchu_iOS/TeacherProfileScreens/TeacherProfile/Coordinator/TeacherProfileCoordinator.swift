
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
    
    func startUpdateTeacherInfo(){
        let updateTeacherInfoCoordinator = UpdateTeacherInfoCoordinator(navigationController: navigationController)
        updateTeacherInfoCoordinator.parentCoordinator = self
        childCoordinators.append(updateTeacherInfoCoordinator)
        updateTeacherInfoCoordinator.start()
    }
    
    func startInformationScreen(){
        let informationCoordinator = InformationCoordinator(navigationController: navigationController)
        informationCoordinator.parentCoordinator = self
        childCoordinators.append(informationCoordinator)
        informationCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool
            in
            return childCoordinator === coordinator
        }){
            childCoordinators.remove(at: index)
        }
    }
    
 
}
