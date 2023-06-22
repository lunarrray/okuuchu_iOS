
import Foundation

//MARK: - Protocols

protocol AddAdvertisementViewModelInput{
    var coordinator: AddAdvertisementCoordinator? { get set }
    var output: AddAdvertisementViewModelOutput? { get set }
    
    func cancelAddingVideo()
    func viewDidDisappear()
    func getDataFromModel()
}

protocol AddAdvertisementViewModelOutput {
    func customizeOutput(with advertisementData: [TitleSubtitleViewModel])
}

//MARK: - Class
class AddAdvertisementViewModel {
    var coordinator: AddAdvertisementCoordinator?
    var output: AddAdvertisementViewModelOutput? {
        didSet {
            output?.customizeOutput(with: advertisementData)
        }
    }
    
    private var advertisementData: [TitleSubtitleViewModel] = []
        
}


//MARK: - Extension

extension AddAdvertisementViewModel: AddAdvertisementViewModelInput{
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func cancelAddingVideo() {
        coordinator?.didFinish()
    }
    
    func getDataFromModel() {
        advertisementData =   [
        TitleSubtitleViewModel(title: "Маалымат", subtitle: ""),
        TitleSubtitleViewModel(title: "Сабактар", subtitle: "", subTextType: .selectingSeveral, onCellUpdate: selectSubjects),
        TitleSubtitleViewModel(title: "Окутуу тили", subtitle: "", subTextType: .selectingSeveral, onCellUpdate: selectLanguages),
        TitleSubtitleViewModel(title: "Окутуу түрү", subtitle: "", subTextType: .selectingSeveral, onCellUpdate: selectTeachingType),
        TitleSubtitleViewModel(title: "Жайгашкан жери", subtitle: "", subTextType: .selectingOne, onCellUpdate: selectLocation),
        TitleSubtitleViewModel(title: "Баасы", subtitle: "", subTextType: .decimal)
        ]
        
        output?.customizeOutput(with: advertisementData)
    }
}


extension AddAdvertisementViewModel {
    private func selectSubjects() -> Void{
        print("selecting lesson")
    }
    
    private func selectLanguages() -> Void{
        print("selecting languages")
    }
    
    private func selectTeachingType() -> Void{
        print("select Teaching Type")
    }
    
    private func selectLocation() -> Void{
        print("select location")
    }
}
