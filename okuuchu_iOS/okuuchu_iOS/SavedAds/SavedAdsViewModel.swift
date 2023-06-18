
import Foundation

//MARK: - Protocols

protocol SavedAdsViewModelInput: AnyObject{
    var coordinator: SavedAdsCoordinator? { get set }
    var output: SavedAdsViewModelOutput? { get set }
    var isSavedAdsMode: Bool? { get set }
    
    func viewDidDisappear()
    func getSavedAdsDataFromModel()
    func cellTapped(at indexPath: IndexPath)
    func performSearch(with text: String)

}

protocol SavedAdsViewModelOutput: AnyObject {
    func customizeOutput(with data: [SubsubtitleViewModel])
}
//MARK: - Class

final class SavedAdsViewModel {
    var coordinator: SavedAdsCoordinator?
    var output: SavedAdsViewModelOutput? {
        didSet {
            output?.customizeOutput(with: subsubTitleData)
        }
    }
    var isSavedAdsMode: Bool? = true
    private var adsData: [AdvertisementData] = []
//    private var filteredAds: [AdvertisementData] = []
    private var subsubTitleData: [SubsubtitleViewModel] = []
}
//MARK: - Extensions

extension SavedAdsViewModel: SavedAdsViewModelInput {
    
    func getSavedAdsDataFromModel() {
        adsData = [
            AdvertisementData(id: 11, title: "Математика для школьников", lessons: [.math], teachingTypes: [.online], image: Asset.lessonImage1.image, price: 300, status: .active),
            AdvertisementData(id: 12, title: "Python для детей, программирование", lessons: [.programming], teachingTypes: [.online], image: Asset.menAvatar.image, price: 400, status: .active),
            AdvertisementData(id: 13, title: "Немецкий", lessons: [.german], teachingTypes: [.online, .offline, .group], image: Asset.womenAvatar.image, price: 370, status: .inactive),
            AdvertisementData(id: 14, title: "Программирование", lessons: [.programming, .math], teachingTypes: [.online], image: Asset.lessonImage2.image, price: 300, status: .active),
            AdvertisementData(id: 15, title: "Программирование и математика", lessons: [.math, .programming], teachingTypes: [.online], image: Asset.lessonImage2.image, price: 340, status: .active),
            AdvertisementData(id: 16, title: "Программирование на C++", lessons: [.programming], teachingTypes: [.online], image: Asset.lessonImage2.image, price: 400, status: .inactive),
            AdvertisementData(id: 17, title: "История за 3 месяца", lessons: [.history], teachingTypes: [.offline, .group], image: Asset.lessonImage1.image, price: 900, status: .active),
            AdvertisementData(id: 18, title: "Немецкий", lessons: [.german], teachingTypes: [.offline, .individual], image: Asset.lessonImage1.image, price: 500, status: .active),
            AdvertisementData(id: 19, title: "Геометрия и математика", lessons: [.geometry, .math], teachingTypes: [.online, .individual], image: Asset.lessonImage2.image, price: 300, status: .active),
            AdvertisementData(id: 110, title: "Биология и химия за 2 месяца", lessons: [.biology, .chemistry], teachingTypes: [.online], image: Asset.lessonImage2.image, price: 800, status: .inactive)
        ]
        
//        filterVideos()
        sendConvertedData()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func cellTapped(at indexPath: IndexPath) {
        let index = indexPath.row
        
        let advertisement = adsData[index]
        coordinator?.startDetailAd(for: advertisement)
    }
    
    func performSearch(with text: String) {
        var filteredAds: [AdvertisementData] = []
        let text = text.lowercased()
        for advertisement in adsData {
            guard let title = advertisement.title?.lowercased() else { return }
            let subject = advertisement.convertLessonsToString().lowercased()
            if title.contains(text) || subject.contains(text) {
                filteredAds.append(advertisement)
            }
        }
        
            adsData = filteredAds
            sendConvertedData()
    }
    
}

extension SavedAdsViewModel {
    
    private func sendConvertedData(){
        subsubTitleData = convertAdsToSubtitleViewModel(from: adsData) ?? []
        output?.customizeOutput(with: subsubTitleData)
    }
    
    private func convertAdsToSubtitleViewModel(from advertisements: [AdvertisementData]) -> [SubsubtitleViewModel]?{
        var subsubtitleViewModels: [SubsubtitleViewModel] = []
        for advertisement in advertisements {
            
            guard let price = advertisement.price.self, let image = advertisement.image else { return nil }
            let lessons = advertisement.convertLessonsToString()
            let teachingTypes = advertisement.convertTeachingTypesToString()
            
            let subsubtitle = SubsubtitleViewModel(title: String(describing: price) + " сом", subtitle:  lessons, subsubtitle: teachingTypes, image: image)
            subsubtitleViewModels.append(subsubtitle)
        }
        
        return subsubtitleViewModels
    }
}
