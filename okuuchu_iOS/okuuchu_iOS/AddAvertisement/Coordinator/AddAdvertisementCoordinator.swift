
import UIKit

class AddAdvertisementCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private var modalNavigationController: UINavigationController?
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        modalNavigationController = UINavigationController()
        modalNavigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: Asset.normalTextColor.color
        ]
        
        let controller: AddAdvertisementController = .init()
        modalNavigationController?.setViewControllers([controller], animated: false)
        controller.viewModel.coordinator = self
        modalNavigationController?.modalPresentationStyle = .fullScreen
        modalNavigationController?.hidesBottomBarWhenPushed = true
        if let modalNavigationController = modalNavigationController {
            navigationController.present(modalNavigationController, animated: true)
        }
    }
    
    func didFinish(){
        parentCoordinator?.childDidFinish(self)
        navigationController.dismiss(animated: true)
    }
}
