
import UIKit

class PersonalAdsCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let controller: PersonalAdsController = .init()
        controller.viewModel.coordinator = self
        controller.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(controller, animated: true)
    }
    
    func startAddAdvertisement(){
        let addAdvertisementCoordinator: AddAdvertisementCoordinator = .init(navigationController: navigationController)
        addAdvertisementCoordinator.parentCoordinator = self
        childCoordinators.append(addAdvertisementCoordinator)
        addAdvertisementCoordinator.start()
    }
    func didFinish(){
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
