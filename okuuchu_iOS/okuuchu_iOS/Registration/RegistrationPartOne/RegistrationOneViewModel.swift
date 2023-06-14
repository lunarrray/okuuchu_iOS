
import Foundation

protocol RegistrationOneViewModelInput {
    var coordinator: RegistrationOneCoordinator? { get set }
    var output: RegistrationOneViewModelOutput? { get set }
    func continueRegistration()
    func openLoginScreen()
}

protocol RegistrationOneViewModelOutput {
}

class RegistrationOneViewModel {
    var coordinator: RegistrationOneCoordinator?
    var output: RegistrationOneViewModelOutput?
}

extension RegistrationOneViewModel: RegistrationOneViewModelInput {
    func continueRegistration(){
        coordinator?.continueRegistration()
    }
    
    func openLoginScreen() {
        coordinator?.startLogin()
    }
}
