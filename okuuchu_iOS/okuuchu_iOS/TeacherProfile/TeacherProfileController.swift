
import Foundation

final class TeacherProfileController: VMController<TeacherProfilePresentable, TeacherProfileViewModelInput> {
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfiugureActions() {
        
    }
}

extension TeacherProfileController: TeacherProfileViewModelOutput{
    
}
