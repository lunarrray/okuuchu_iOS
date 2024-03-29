
import Foundation
import Swinject

public final class AuthModulesAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        
        container.autoregister(
            LoginViewModelInput.self,
            initializer: LoginViewModel.init)
        
        container.autoregister(
            RegistrationOneViewModelInput.self,
            initializer: RegistrationOneViewModel.init)
        
        container.autoregister(
            RegistrationTwoViewModelInput.self,
            initializer: RegistrationTwoViewModel.init)
        
        container.autoregister(
            TeacherProfileViewModelInput.self,
            initializer: TeacherProfileViewModel.init)
        
        container.autoregister(
            UpdateTeacherInfoViewModelInput.self,
            initializer: UpdateTeacherInfoViewModel.init)
        
        container.autoregister(
            InformationViewModelInput.self,
            initializer: InformationViewModel.init)
        
        container.autoregister(
            AboutAppViewModelInput.self,
            initializer: AboutAppViewModel.init)
        
        container.autoregister(
            ScheduleViewModelInput.self,
            initializer: ScheduleViewModel.init)
        
        container.autoregister(
            ReviewsViewModelInput.self,
            initializer: ReviewsViewModel.init)
        
        container.autoregister(
            PersonalAdsViewModelInput.self,
            initializer: PersonalAdsViewModel.init)
        
        container.autoregister(
            LessonsListViewModelInput.self,
            initializer: LessonsListViewModel.init)
        
        container.autoregister(
            RecordedVideosViewModelInput.self,
            initializer: RecordedVideosViewModel.init)
        
        container.autoregister(
            AddVideoViewModelInput.self,
            initializer: AddVideoViewModel.init)
        
        container.autoregister(
            MainScreenViewModelInput.self,
            initializer: MainScreenViewModel.init)
        
        container.autoregister(
            SavedAdsViewModelInput.self,
            initializer: SavedAdsViewModel.init)
        
        container.autoregister(
            AddAdvertisementViewModelInput.self,
            initializer: AddAdvertisementViewModel.init)
        
        container.autoregister(
            VideoListViewModelInput.self,
            initializer: VideoListViewModel.init)
        
        container.autoregister(
            VideoInfoViewModelInput.self,
            initializer: VideoInfoViewModel.init)
        
        container.autoregister(
            TutorAccountViewModelInput.self,
            initializer: TutorAccountViewModel.init)
        
        container.autoregister(
            AddReviewViewModelInput.self,
            initializer: AddReviewViewModel.init)
    
        container.autoregister(
            DetailAdViewModelInput.self,
            initializer: DetailAdViewModel.init)
    
    }
    
    
}
