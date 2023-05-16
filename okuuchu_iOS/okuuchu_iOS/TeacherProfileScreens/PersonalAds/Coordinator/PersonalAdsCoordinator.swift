
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
        navigationController.pushViewController(controller, animated: true)
    }
}
