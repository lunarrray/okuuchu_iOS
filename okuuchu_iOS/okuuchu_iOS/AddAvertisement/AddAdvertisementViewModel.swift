
import Foundation

//MARK: - Protocols

protocol AddAdvertisementViewModelInput{
    var coordinator: AddAdvertisementCoordinator? { get set }
    var output: AddAdvertisementViewModelOutput? { get set }
    
    func cancelAddingVideo()
    func viewDidDisappear()

}

protocol AddAdvertisementViewModelOutput {
    func customizeOutput()
}

//MARK: - Class
class AddAdvertisementViewModel {
    var coordinator: AddAdvertisementCoordinator?
    var output: AddAdvertisementViewModelOutput? {
        didSet {
            output?.customizeOutput()
        }
    }
}


//MARK: - Extension

extension AddAdvertisementViewModel: AddAdvertisementViewModelInput{
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func cancelAddingVideo() {
        coordinator?.didFinish()
    }
}
