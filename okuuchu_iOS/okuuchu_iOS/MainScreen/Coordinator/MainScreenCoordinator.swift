

import UIKit

class MainScreenCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let controller: MainScreenController = .init()
        controller.viewModel.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
}
