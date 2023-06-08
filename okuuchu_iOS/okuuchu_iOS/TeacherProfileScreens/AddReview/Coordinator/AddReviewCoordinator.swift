
import UIKit

final class AddReviewCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    private var modalNavigationController: UINavigationController?
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() { }
    
    func openAddReview(for id: Int){
        modalNavigationController = UINavigationController()
        modalNavigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: Asset.normalTextColor.color
        ]
        let controller: AddReviewController = .init()
        modalNavigationController?.setViewControllers([controller], animated: false)
        controller.viewModel.coordinator = self
        if let modalNavigationController {
            navigationController.present(modalNavigationController, animated: true)
        }
    }
    
    func didFinish(){
        parentCoordinator?.childDidFinish(self)
        navigationController.dismiss(animated: true)
    }
}
