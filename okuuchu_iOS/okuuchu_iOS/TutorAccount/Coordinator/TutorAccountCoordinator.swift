
import UIKit

final class TutorAccountCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() { }
    
    func openTutorAccount(tutor: TutorData) {
        let controller: TutorAccountController = .init()
        controller.viewModel.coordinator = self
        controller.viewModel.tutorData = tutor
        controller.hidesBottomBarWhenPushed = true
        controller.navigationItem.title = tutor.name
        navigationController.pushViewController(controller, animated: true)
    }
    
    func startSchedule(){
        let scheduleCoordinator = ScheduleCoordinator(navigationController: navigationController)
        scheduleCoordinator.parentCoordinator = self
        childCoordinators.append(scheduleCoordinator)
        scheduleCoordinator.openSchedule(for: 1, isEdidtingMode: false)
    }
 
    func startRecordedLessons(with lessons: [Lesson]){
        let lessonsListCoordinator = LessonsListCoordinator(navigationController: navigationController)
        lessonsListCoordinator.parentCoordinator = self
        childCoordinators.append(lessonsListCoordinator)
        lessonsListCoordinator.openLessonsWith(list: lessons, isEditingMode: false)
    }
    
    func startReviews(reviews: [ReviewData]){
        let reviewsCoordinator = ReviewsCoordinator(navigationController: navigationController)
        reviewsCoordinator.parentCoordinator = self
        childCoordinators.append(reviewsCoordinator)
        reviewsCoordinator.openReviews(with: reviews, isAddingReviewMode: true)
    }
    
    func startPersonalAds(for id: Int){
        let savedVideosCoordinator = SavedAdsCoordinator(navigationController: navigationController)
        savedVideosCoordinator.parentCoordinator = self
        childCoordinators.append(savedVideosCoordinator)
        savedVideosCoordinator.openSavedAds(for: id)
    }
    
    func didFinsish(){
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
