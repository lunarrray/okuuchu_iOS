
import UIKit

final class VideoInfoCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() { }
    
    func openVideoInfo(video: RecordedVideo){
        let controller: VideoInfoController = .init()
        controller.viewModel.coordinator = self
        controller.viewModel.videoData = video
        navigationController.pushViewController(controller, animated: true)
    }
    
    func startSafari(with url: URL){
        let safariCoordinator: SafariCoordinator = .init(navigationController: navigationController)
        childCoordinators.append(safariCoordinator)
        safariCoordinator.parentCoordinator = self
        safariCoordinator.openSafari(with: url)
    }
    
    func startVideoTutor(for tutor: TutorData){
        let tutorAccountCoordinator: TutorAccountCoordinator = .init(navigationController: navigationController)
        tutorAccountCoordinator.parentCoordinator = self
        childCoordinators.append(tutorAccountCoordinator)
        tutorAccountCoordinator.openTutorAccount(tutor: tutor)
    }
    
    func didFinish(){
        parentCoordinator?.childDidFinish(self)
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

