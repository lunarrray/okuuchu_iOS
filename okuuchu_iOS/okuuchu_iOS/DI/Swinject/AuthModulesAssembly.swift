
import Foundation
import Swinject

public final class AuthModulesAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        
        container.autoregister(
            LoginViewModelInput.self,
            initializer: LoginViewModel.init)
    }
    
    
}
