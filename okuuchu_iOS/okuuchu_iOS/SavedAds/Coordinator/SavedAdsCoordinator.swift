

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
        controller.navigationItem.title = "Сакталган жарнамалар"
        navigationController.pushViewController(controller, animated: true)
    }
    
    func openSavedAds(for id: Int) {
        let controller: SavedAdsController = .init()
        controller.viewModel.coordinator = self
        controller.viewModel.isSavedAdsMode = false
        controller.navigationItem.title = "Жарнамалар"
        navigationController.pushViewController(controller, animated: true)
    }
    
    func startDetailAd(for advertisement: AdvertisementData){
        let detailAdCoordinator: DetailAdCoordinator = .init(navigationController: navigationController)
        detailAdCoordinator.parentCoordinator = self
        childCoordinators.append(detailAdCoordinator)
        detailAdCoordinator.openDetailAdvertisement(ad: advertisement)
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
