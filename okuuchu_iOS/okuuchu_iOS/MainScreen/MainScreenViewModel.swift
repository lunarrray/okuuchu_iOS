
import Foundation

//MARK: - Protocols

protocol MainScreenViewModelInput:  AnyObject {
    var coordinator: MainScreenCoordinator? { get set }
    var output: MainScreenViewModelOutput? { get set }
}

protocol MainScreenViewModelOutput: AnyObject {
    func customizeOutput()
}

//MARK: - Class

final class MainScreenViewModel {
    var coordinator: MainScreenCoordinator?
    weak var output: MainScreenViewModelOutput?{
        didSet {
            output?.customizeOutput()
        }
    }
}


//MARK: - Extension

extension MainScreenViewModel: MainScreenViewModelInput {
    
}
