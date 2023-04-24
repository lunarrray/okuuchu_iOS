
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
    }
    
    
}
