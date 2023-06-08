
import UIKit

class ScheduleCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() { }
    
    func openSchedule(for id: Int, isEdidtingMode: Bool) {
        let controller: ScheduleController = .init()
        controller.viewModel.coordinator = self
        controller.viewModel.isEditingMode = isEdidtingMode
        controller.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(controller, animated: true)

    }
    
    func didFinish(){
        parentCoordinator?.childDidFinish(self)
    }
}
