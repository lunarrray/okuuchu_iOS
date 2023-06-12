
import Foundation

//MARK: - Protocols

protocol MainScreenViewModelInput:  AnyObject {
    var coordinator: MainScreenCoordinator? { get set }
    var output: MainScreenViewModelOutput? { get set }
    
    func toggleCollectionView()
    func getActiveAdsDataFromModel()
    func cellTapped(at indexPath: IndexPath)
}

protocol MainScreenViewModelOutput: AnyObject {
    func customizeOutput(with data: [SubsubtitleViewModel])
}

//MARK: - Class

final class MainScreenViewModel {
    var coordinator: MainScreenCoordinator?
    weak var output: MainScreenViewModelOutput?{
        didSet {
            output?.customizeOutput(with: subsubtitleViewModel)
        }
    }
    
    private var adsData: [AdvertisementData] = []
    private var tutorsData: [TutorData] = []
    private var subsubtitleViewModel: [SubsubtitleViewModel] = []
    private var isAdsData: Bool = true
}


//MARK: - Extension

extension MainScreenViewModel: MainScreenViewModelInput {
    
    func getActiveAdsDataFromModel() {
        
        adsData = getAds()
        sendConvertedData()

    }
    
    func toggleCollectionView() {
        if isAdsData{
            isAdsData = false
            tutorsData = getTutors()
        } else {
            isAdsData = true
            adsData = getAds()
        }
        
        sendConvertedData()
    }
    
    func cellTapped(at indexPath: IndexPath) {
        let index = indexPath.row
        
        if isAdsData {
            let advertisement = adsData[index]
            coordinator?.startDetailAd(for: advertisement)
        } else {
            let tutor = tutorsData[index]
            coordinator?.startVideoTutor(for: tutor)
        }
    }
}

extension MainScreenViewModel {
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
    
    private func convertTutorsToSubtitleViewModel(from tutors: [TutorData]) -> [SubsubtitleViewModel]?{
        var subsubtitleViewModels: [SubsubtitleViewModel] = []
        for tutor in tutors {
            
            guard let name = tutor.name, let image = tutor.image else { return nil }
            let lessons = tutor.convertLessonsToString()
            
            let subsubtitle = SubsubtitleViewModel(title: String(describing: name), subtitle:  lessons, image: image)
            subsubtitleViewModels.append(subsubtitle)
        }
        
        return subsubtitleViewModels
    }
    
    private func sendConvertedData(){
        if isAdsData {
            subsubtitleViewModel = convertAdsToSubtitleViewModel(from: adsData) ?? []
        } else {
            subsubtitleViewModel = convertTutorsToSubtitleViewModel(from: tutorsData) ?? []
        }
        output?.customizeOutput(with: subsubtitleViewModel)
    }
    
    private func getAds() -> [AdvertisementData]{
        let ads: [AdvertisementData] = [
            AdvertisementData(id: 11, tutor: TutorData(name: "Мария Иванова", image: Asset.womenAvatar.image, phoneNumber: "+996990808080"), title: "Английский язык для начальных классов", lessons: [.math], teachingLanguages: [.russian, .english], teachingTypes: [.online], location: .chui, description: "Lörem ipsum klimatmat fibid tisos, supöning retopi. Geodögisk ont vifilig. Föder vitigt, gyförat. Egol seminas köns gepåktig timypp. ksjbvbs sdvkbsvbs hdvbsdvbsd hdvudv hdvuv udgviugsv iudvugv ohdviuh hdvugv oispo [idf paojhf", image: Asset.mathImage.image, whatsappNumber: "+996704304786", telegramNic: "Kerimkullova", price: 300, status: .active),
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
        
        return ads
    }
    
    private func getTutors() -> [TutorData]{
        let tutors: [TutorData] = [
            TutorData(name: "Алексей Ромашенко", image: Asset.prof.image, description: "ОLörem ipsum klimatmat fibid tisos, supöning retopi. Geodögisk ont vifilig. Föder vitigt, gyförat. Egol seminas köns gepåktig timypp. sjdvbvb dbvbdvbv dkbvdbv kjdbvbb jsdvbjbbv sdvbvbbvk", education: "Lörem ipsum klimatmat fibid tisos, supöning retopi. Geodögisk", phoneNumber: "+1234567890", whatsappNumber: "+996704304786", telegramNic: "Kerimkullova", workExperience: "6 лет", location: .chui, teachingLanguages: [.russian, .english], lessons: [.math, .programming], reviews: [ReviewData(assessment: 3)]),
            TutorData(name: "Айдана Касымова", image: Asset.prof1.image ,lessons: [.math]),
            TutorData(name: "Эрмек Токтогулов", image: Asset.womenAvatar.image ,lessons: [.physics]),
            TutorData(name: "Гулназ Садыкова", image: Asset.prof4.image ,lessons: [.biology, .chemistry]),
            TutorData(name: "Жанар Алиева", image: Asset.menAvatar.image ,lessons: [.english]),
            TutorData(name: "Курманжан Жумабеков", image: Asset.womenAvatar.image ,lessons: [.german, .english, .russian]),
            TutorData(name: "Лейла Джекшеналиева", image: Asset.avatarImg.image ,lessons: [.math]),
            TutorData(name: "Мирбек Турсунов ", image: Asset.prof.image ,lessons: [.kyrgyzLiterature, .kyrgyz]),
            TutorData(name: "Нургуль Каримова", image: Asset.prof1.image ,lessons: [.turkish]),
            TutorData(name: "Алексей Ромашенко", image: Asset.menAvatar.image ,lessons: [.programming]),
        ]
        return tutors
    }
}
