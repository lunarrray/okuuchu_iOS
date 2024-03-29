
import UIKit

class TeacherProfileCoordinator: Coordinator{
    private(set) var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let teacherProfileController: TeacherProfileController = .init()
        teacherProfileController.viewModel.coordinator = self
        navigationController.viewControllers = [teacherProfileController]
    }
    
    func startUpdateTeacherInfo(){
        let updateTeacherInfoCoordinator = UpdateTeacherInfoCoordinator(navigationController: navigationController)
        updateTeacherInfoCoordinator.parentCoordinator = self
        childCoordinators.append(updateTeacherInfoCoordinator)
        updateTeacherInfoCoordinator.start()
    }
    
    func startInformationScreen(){
        let informationCoordinator = InformationCoordinator(navigationController: navigationController)
        informationCoordinator.parentCoordinator = self
        childCoordinators.append(informationCoordinator)
        informationCoordinator.start()
    }
    
    func startSchedule(){
        let scheduleCoordinator = ScheduleCoordinator(navigationController: navigationController)
        scheduleCoordinator.parentCoordinator = self
        childCoordinators.append(scheduleCoordinator)
        scheduleCoordinator.openSchedule(for: 1, isEdidtingMode: true)
    }
    
    func startReviews(reviews: [ReviewData]){
        let reviewsCoordinator = ReviewsCoordinator(navigationController: navigationController)
        reviewsCoordinator.parentCoordinator = self
        childCoordinators.append(reviewsCoordinator)
        reviewsCoordinator.openReviews(with: reviews, isAddingReviewMode: false)
    }
    
    func startPersonalAds(){
        let adsCoordinator = PersonalAdsCoordinator(navigationController: navigationController)
        adsCoordinator.parentCoordinator = self
        childCoordinators.append(adsCoordinator)
        adsCoordinator.start()
    }
    
    func startRecordedLessons(with lessons: [Lesson]){
        let lessonsListCoordinator = LessonsListCoordinator(navigationController: navigationController)
        lessonsListCoordinator.parentCoordinator = self
        childCoordinators.append(lessonsListCoordinator)
        lessonsListCoordinator.openLessonsWith(list: lessons, isEditingMode: true)
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
