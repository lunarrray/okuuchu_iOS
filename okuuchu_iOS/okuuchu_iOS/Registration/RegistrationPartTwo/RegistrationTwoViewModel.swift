
import Foundation

protocol RegistrationTwoViewModelInput {
    var coordinator: RegistrationTwoCoordinator? { get set }
    var output: RegistrationTwoViewModelOutput? { get set }
    func openLoginScreen()
}

protocol RegistrationTwoViewModelOutput {
    
}

class RegistrationTwoViewModel {
    var coordinator: RegistrationTwoCoordinator?
    var output: RegistrationTwoViewModelOutput?
}

extension RegistrationTwoViewModel: RegistrationTwoViewModelInput {
    func openLoginScreen() {
        coordinator?.startLogin()
    }
}
