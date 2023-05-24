
import Foundation

//MARK: - Protocols

protocol SavedAdsViewModelInput: AnyObject{
    var coordinator: SavedAdsCoordinator? { get set }
    var output: SavedAdsViewModelOutput? { get set }
    
    func getSavedAdsDataFromModel()
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
    
    private var adsData: [AdvertisementData] = []
    private var subsubTitleData: [SubsubtitleViewModel] = []
}
//MARK: - Extensions

extension SavedAdsViewModel: SavedAdsViewModelInput {
    
    func getSavedAdsDataFromModel() {
        adsData = [
            AdvertisementData(id: 11, lessons: [.math], teachingTypes: [.online], image: Asset.lessonImage1.image, price: 300, status: .active),
            AdvertisementData(id: 12, lessons: [.programming], teachingTypes: [.online], image: Asset.menAvatar.image, price: 400, status: .active),
            AdvertisementData(id: 13, lessons: [.german], teachingTypes: [.online, .offline, .group], image: Asset.womenAvatar.image, price: 370, status: .inactive),
            AdvertisementData(id: 14, lessons: [.programming, .math], teachingTypes: [.online], image: Asset.lessonImage2.image, price: 300, status: .active),
            AdvertisementData(id: 15, lessons: [.math, .programming], teachingTypes: [.online], image: Asset.lessonImage2.image, price: 340, status: .active),
            AdvertisementData(id: 16, lessons: [.programming], teachingTypes: [.online], image: Asset.lessonImage2.image, price: 400, status: .inactive),
            AdvertisementData(id: 17, lessons: [.history], teachingTypes: [.offline, .group], image: Asset.lessonImage1.image, price: 900, status: .active),
            AdvertisementData(id: 18, lessons: [.german], teachingTypes: [.offline, .individual], image: Asset.lessonImage1.image, price: 500, status: .active),
            AdvertisementData(id: 19, lessons: [.geometry, .math], teachingTypes: [.online, .individual], image: Asset.lessonImage2.image, price: 300, status: .active),
            AdvertisementData(id: 110, lessons: [.programming, .biology, .chemistry], teachingTypes: [.online], image: Asset.lessonImage2.image, price: 800, status: .inactive)
        ]
        
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
            
            guard let price = advertisement.price.self, let lessonsData = advertisement.lessons, let teachingTypesData = advertisement.teachingTypes, let image = advertisement.image else { return nil }
            var lessons = ""
            let spacing = ", "
            for (i, item) in lessonsData.enumerated() {
                lessons += item.title
                if i != lessonsData.count - 1 {
                    lessons += spacing
                }
            }
            var teachingTypes = ""
            for (i, item) in teachingTypesData.enumerated() {
                teachingTypes += item.title
                if i != teachingTypesData.count - 1 {
                    teachingTypes += spacing
                }
            }
            
            let subsubtitle = SubsubtitleViewModel(title: String(describing: price) + " сом", subtitle:  lessons, subsubtitle: teachingTypes, image: image)
            subsubtitleViewModels.append(subsubtitle)
        }
        
        return subsubtitleViewModels
    }
}
