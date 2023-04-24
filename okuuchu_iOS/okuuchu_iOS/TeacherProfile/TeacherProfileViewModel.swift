
import Foundation

protocol TeacherProfileViewModelInput {
    var coordinator: TeacherProfileCoordinator? { get set }
    var output: TeacherProfileViewModelOutput? { get set }
}

protocol TeacherProfileViewModelOutput {
    
}

final class TeacherProfileViewModel {
    var coordinator: TeacherProfileCoordinator?
    var output: TeacherProfileViewModelOutput?
}

extension TeacherProfileViewModel: TeacherProfileViewModelInput {
    
}
