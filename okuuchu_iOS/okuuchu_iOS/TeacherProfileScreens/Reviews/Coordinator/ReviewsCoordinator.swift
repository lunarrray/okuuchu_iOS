

import UIKit

class ReviewsCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var parentCoordinator: TeacherProfileCoordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
//        let controller: ReviewsController = .init()
//        controller.viewModel.coordinator = self
//        controller.hidesBottomBarWhenPushed = true
//        navigationController.pushViewController(controller, animated: true)
    }
    
    func openReviews(with reviews: [ReviewData]){
        let controller: ReviewsController = .init()
        controller.viewModel.coordinator = self
        controller.viewModel.allReviews = reviews
        controller.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(controller, animated: true)
    }
    
    func didFinish(){
        parentCoordinator?.childDidFinish(self)
    }
}
