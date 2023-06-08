

import UIKit

class ReviewsCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() { }
    
    func openReviews(with reviews: [ReviewData], isAddingReviewMode: Bool){
        let controller: ReviewsController = .init()
        controller.viewModel.coordinator = self
        controller.viewModel.allReviews = reviews
        controller.viewModel.isAddingReviewMode = isAddingReviewMode
        controller.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(controller, animated: true)
    }
    
    func startAddReview(for id: Int){
        let addReviewCoordinator: AddReviewCoordinator = .init(navigationController: navigationController)
        addReviewCoordinator.parentCoordinator = self
        childCoordinators.append(addReviewCoordinator)
        addReviewCoordinator.openAddReview(for: id)
    }
    
    func didFinish(){
        parentCoordinator?.childDidFinish(self)
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool
            in
            return childCoordinator === coordinator
        }){
            childCoordinators.remove(at: index)
        }
    }
}
