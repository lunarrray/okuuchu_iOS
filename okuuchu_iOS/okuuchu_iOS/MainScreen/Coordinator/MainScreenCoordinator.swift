

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
    
    func startDetailTutor(for tutor: TutorData){
        let tutorAccountCoordinator: TutorAccountCoordinator = .init(navigationController: navigationController)
        tutorAccountCoordinator.parentCoordinator = self
        childCoordinators.append(tutorAccountCoordinator)
        tutorAccountCoordinator.openTutorAccount(tutor: tutor)
    }
    
    func startDetailAd(for advertisement: AdvertisementData){
        let detailAdCoordinator: DetailAdCoordinator = .init(navigationController: navigationController)
        detailAdCoordinator.parentCoordinator = self
        childCoordinators.append(detailAdCoordinator)
        detailAdCoordinator.openDetailAdvertisement(ad: advertisement)
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
