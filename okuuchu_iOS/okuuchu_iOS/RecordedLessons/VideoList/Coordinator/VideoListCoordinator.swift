
import UIKit

class VideoListCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() { }

    func openVideoList(for subject: Lesson){
        let controller: VideoListController = .init()
        controller.viewModel.coordinator = self
        controller.viewModel.subject = subject
        controller.navigationItem.title = subject.title
        controller.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(controller, animated: true)
    }
    
    func startVideoInfo(video: RecordedVideo) {
        let videoInfoCoordinator: VideoInfoCoordinator = .init(navigationController: navigationController)
        videoInfoCoordinator.parentCoordinator = self
        childCoordinators.append(videoInfoCoordinator)
        videoInfoCoordinator.openVideoInfo(video: video)
    }
//    
//    func startSafari(with url: URL){
//        let safariCoordinator: SafariCoordinator = .init(navigationController: navigationController)
//        childCoordinators.append(safariCoordinator)
//        safariCoordinator.parentCoordinator = self
//        safariCoordinator.openSafari(with: url)
//    }
//    
//    func startAddVideo(for subject: Lesson){
//        let addVideoCoordinator: AddVideoCoordinator = .init(navigationController: navigationController)
//        addVideoCoordinator.parentCoordinator = self
//        childCoordinators.append(addVideoCoordinator)
//        addVideoCoordinator.openAddVideo(for: subject)
//    }
    
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
