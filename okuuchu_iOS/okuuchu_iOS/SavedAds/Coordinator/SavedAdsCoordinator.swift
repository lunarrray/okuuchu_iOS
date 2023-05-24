

import UIKit

class SavedAdsCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let controller: SavedAdsController = .init()
        controller.viewModel.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
}
