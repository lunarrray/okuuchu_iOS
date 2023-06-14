
import UIKit

final class DetailAdCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() { }
    
    func openDetailAdvertisement(ad: AdvertisementData) {
        let controller: DetailAdController = .init()
        controller.viewModel.coordinator = self
        controller.viewModel.advertisement = ad
        controller.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(controller, animated: true)
    }
    
    func startDetailTutor(for tutor: TutorData){
        let tutorAccountCoordinator: TutorAccountCoordinator = .init(navigationController: navigationController)
        tutorAccountCoordinator.parentCoordinator = self
        childCoordinators.append(tutorAccountCoordinator)
        tutorAccountCoordinator.openTutorAccount(tutor: tutor)
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
