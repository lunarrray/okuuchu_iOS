
import UIKit

class LessonsListCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let controller: LessonsListController = .init()
        controller.viewModel.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func openLessonsWith(list: [Lesson], isEditingMode: Bool){
        let controller: LessonsListController = .init()
        controller.viewModel.coordinator = self
        controller.viewModel.lessons = list
        controller.viewModel.isEditingMode = isEditingMode
        controller.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(controller, animated: true)
    }
    
    func startRecordedVideos(for subject: Lesson, id: Int, isEditingMode: Bool){
        let recordedVideosCoordinator: RecordedVideosCoordinator = .init(navigationController: navigationController)
        recordedVideosCoordinator.parentCoordinator = self
        childCoordinators.append(recordedVideosCoordinator)
        recordedVideosCoordinator.openRecordedVideos(for: subject, id: id, isEditingMode: isEditingMode)
    }
    
    func startVideoList(for subject: Lesson) {
        let videoListCoordinator: VideoListCoordinator = .init(navigationController: navigationController)
        videoListCoordinator.parentCoordinator = self
        childCoordinators.append(videoListCoordinator)
        videoListCoordinator.openVideoList(for: subject)
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
