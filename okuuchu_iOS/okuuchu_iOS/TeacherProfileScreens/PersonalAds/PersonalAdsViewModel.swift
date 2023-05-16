
import Foundation

//MARK: - Protocols

protocol PersonalAdsViewModelInput {
    var coordinator: PersonalAdsCoordinator? { get set }
    var output: PersonalAdsViewModelOutput? { get set }
    
    func toggleCollectionView(segmentedControlIndex: Int)
    func getActiveAdsDataFromModel()
}

protocol PersonalAdsViewModelOutput: AnyObject {
    func customizeOutput(with data: [AdvertisementData])
}

//MARK: - Class

final class PersonalAdsViewModel {
    var coordinator: PersonalAdsCoordinator?
    weak var output: PersonalAdsViewModelOutput?{
        didSet{
            output?.customizeOutput(with: adsData)
        }
    }
    
    private var adsData: [AdvertisementData] = []
}

//MARK: - Extension

extension PersonalAdsViewModel: PersonalAdsViewModelInput {
    func getActiveAdsDataFromModel() {
        
        adsData = [
            AdvertisementData(lessons: [.math], teachingTypes: [.online], image: Asset.lessonImage1.image, price: 300, status: .active),
            AdvertisementData(lessons: [.programming], teachingTypes: [.online], image: Asset.menAvatar.image, price: 400, status: .active),
            AdvertisementData(lessons: [.programming, .math], teachingTypes: [.online], image: Asset.lessonImage2.image, price: 300, status: .active),
            AdvertisementData(lessons: [.math, .programming], teachingTypes: [.online], image: Asset.lessonImage2.image, price: 340, status: .active),
            AdvertisementData(lessons: [.history], teachingTypes: [.offline, .group], image: Asset.lessonImage1.image, price: 900, status: .active),
            AdvertisementData(lessons: [.german], teachingTypes: [.offline, .individual], image: Asset.lessonImage1.image, price: 500, status: .active),
            AdvertisementData(lessons: [.geometry, .math], teachingTypes: [.online, .individual], image: Asset.lessonImage2.image, price: 300, status: .active),
        ]
        
        output?.customizeOutput(with: adsData)
    }
    
    func toggleCollectionView(segmentedControlIndex: Int) {
        if segmentedControlIndex == 0 {
            adsData = [
                AdvertisementData(lessons: [.math], teachingTypes: [.online], image: Asset.lessonImage1.image, price: 300, status: .active),
                AdvertisementData(lessons: [.programming], teachingTypes: [.online], image: Asset.menAvatar.image, price: 400, status: .active),
                AdvertisementData(lessons: [.programming, .math], teachingTypes: [.online], image: Asset.lessonImage2.image, price: 300, status: .active),
                AdvertisementData(lessons: [.math, .programming], teachingTypes: [.online], image: Asset.lessonImage2.image, price: 340, status: .active),
                AdvertisementData(lessons: [.history], teachingTypes: [.offline, .group], image: Asset.lessonImage1.image, price: 900, status: .active),
                AdvertisementData(lessons: [.german], teachingTypes: [.offline, .individual], image: Asset.lessonImage1.image, price: 500, status: .active),
                AdvertisementData(lessons: [.geometry, .math], teachingTypes: [.online, .individual], image: Asset.lessonImage2.image, price: 300, status: .active),
            ]
        } else if segmentedControlIndex == 1 {
            adsData = [
                AdvertisementData(lessons: [.german], teachingTypes: [.online, .offline, .group], image: Asset.womenAvatar.image, price: 370, status: .inactive),
                AdvertisementData(lessons: [.programming], teachingTypes: [.online], image: Asset.lessonImage2.image, price: 400, status: .inactive),
                AdvertisementData(lessons: [.programming, .biology, .chemistry], teachingTypes: [.online], image: Asset.lessonImage2.image, price: 800, status: .inactive),
                ]
        }
        
        output?.customizeOutput(with: adsData)
    }
}
