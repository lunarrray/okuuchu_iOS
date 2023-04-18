
import Foundation

protocol RegistrationViewModelInput {
    var coordinator: RegistrationCoordinator? { get set }
    var output: RegistrationViewModelOutput? { get set }
}

protocol RegistrationViewModelOutput {
    
}

class RegistrationViewModel {
    var coordinator: RegistrationCoordinator?
    var output: RegistrationViewModelOutput?
}

extension RegistrationViewModel: RegistrationViewModelInput {
    
}
