
import UIKit

class AddVideoCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private var modalNavigationController: UINavigationController?
    var parentCoordinator: RecordedVideosCoordinator?
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    func openAddVideo(for subject: Lesson){
        modalNavigationController = UINavigationController()
        modalNavigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: Asset.normalTextColor.color
        ]
        
        let controller: AddVideoController = .init()
        modalNavigationController?.setViewControllers([controller], animated: false)
        controller.viewModel.coordinator = self
        controller.viewModel.subject = subject
        modalNavigationController?.modalPresentationStyle = .fullScreen
        if let modalNavigationController = modalNavigationController {
            navigationController.present(modalNavigationController, animated: true)
        }
    }
    
    
    func didFinishAddingVideo(){
        parentCoordinator?.onUpdateVideos()
        didFinish()
    }
    
    func didFinish(){
        navigationController.dismiss(animated: true)
        parentCoordinator?.childDidFinish(self)
    }
    
}
