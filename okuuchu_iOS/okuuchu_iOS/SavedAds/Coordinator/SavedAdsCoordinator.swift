

import UIKit

class SavedAdsCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let controller: SavedAdsController = .init()
        controller.viewModel.coordinator = self
        controller.navigationItem.title = "Сохраненные обьявления"
        navigationController.pushViewController(controller, animated: true)
    }
    
    func openSavedAds(for id: Int) {
        let controller: SavedAdsController = .init()
        controller.viewModel.coordinator = self
        controller.viewModel.isSavedAdsMode = false
        controller.navigationItem.title = "Обьявления"
        navigationController.pushViewController(controller, animated: true)
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
