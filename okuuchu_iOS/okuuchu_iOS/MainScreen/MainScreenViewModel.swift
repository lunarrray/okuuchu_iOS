
import Foundation

//MARK: - Protocols

protocol MainScreenViewModelInput:  AnyObject {
    var coordinator: MainScreenCoordinator? { get set }
    var output: MainScreenViewModelOutput? { get set }
    
    func getDataFromModel()
    func toggleCollectionView()
    func cellTapped(at indexPath: IndexPath)
    func performSearch(with text: String)
    
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
    private var filteredAdvertisement: [AdvertisementData] = []
    private var tutorsData: [TutorData] = []
    private var filteredTutors: [TutorData] = []
    private var subsubtitleViewModel: [SubsubtitleViewModel] = []
    private var isAdsData: Bool = true
}


//MARK: - Extension

extension MainScreenViewModel: MainScreenViewModelInput {
    
    func getDataFromModel() {
        if isAdsData {
            adsData = getAds()
            filteredAdvertisement = adsData
        } else {
            tutorsData = getTutors()
            filteredTutors = tutorsData
        }
        
        sendConvertedData()
        
    }
    
    func toggleCollectionView() {
        if isAdsData{
            isAdsData = false
        } else {
            isAdsData = true
        }
        getDataFromModel()
    }
    
    func cellTapped(at indexPath: IndexPath) {
        let index = indexPath.row
        
        if isAdsData {
            let advertisement = filteredAdvertisement[index]
            coordinator?.startDetailAd(for: advertisement)
        } else {
            let tutor = filteredTutors[index]
            coordinator?.startDetailTutor(for: tutor)
        }
    }
    
    func performSearch(with text: String) {
        if isAdsData {
            var filteredAds: [AdvertisementData] = []
            let text = text.lowercased()
            for advertisement in adsData {
                guard let title = advertisement.title?.lowercased() else { return }
                let subject = advertisement.convertLessonsToString().lowercased()
                if title.contains(text) || subject.contains(text) {
                    filteredAds.append(advertisement)
                }
            }
            
            filteredAdvertisement = filteredAds
            sendConvertedData()
            
        } else {
            var filteredTuts: [TutorData] = []
            let text = text.lowercased()
            for tutor in tutorsData {
                guard let name = tutor.name?.lowercased() else { return }
                let subject = tutor.convertLessonsToString().lowercased()
                if name.contains(text) || subject.contains(text) {
                    filteredTuts.append(tutor)
                }
            }
            
            filteredTutors = filteredTuts
            sendConvertedData()
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
            subsubtitleViewModel = convertAdsToSubtitleViewModel(from: filteredAdvertisement) ?? []
            
        } else {
            subsubtitleViewModel = convertTutorsToSubtitleViewModel(from: filteredTutors) ?? []
        }
        output?.customizeOutput(with: subsubtitleViewModel)
    }
    
    private func getAds() -> [AdvertisementData]{
        let tutor = TutorData(name: "Алексей Ромашенко", image: Asset.prof.image, description: "ОLörem ipsum klimatmat fibid tisos, supöning retopi. Geodögisk ont vifilig. Föder vitigt, gyförat. Egol seminas köns gepåktig timypp. sjdvbvb dbvbdvbv dkbvdbv kjdbvbb jsdvbjbbv sdvbvbbvk", education: "Lörem ipsum klimatmat fibid tisos, supöning retopi. Geodögisk", phoneNumber: "+1234567890", whatsappNumber: "+996704304786", telegramNic: "Kerimkullova", workExperience: "6 лет", location: .chui, teachingLanguages: [.russian, .english], lessons: [.math, .programming], reviews: [ReviewData(assessment: 3)])
        
        let ads: [AdvertisementData] = [
            AdvertisementData(id: 11, tutor: tutor, title: "Английский язык для начальных классов", lessons: [.english], teachingLanguages: [.russian, .english], teachingTypes: [.online, .offline], location: .chui, description: "Lörem ipsum klimatmat fibid tisos, supöning retopi. Geodögisk ont vifilig. Föder vitigt, gyförat. Egol seminas köns gepåktig timypp. ksjbvbs sdvkbsvbs hdvbsdvbsd hdvudv hdvuv udgviugsv iudvugv ohdviuh hdvugv oispo [idf paojhf", image: Asset.mathImage.image, whatsappNumber: "+996704304786", telegramNic: "Kerimkullova", price: 300, status: .active),
            AdvertisementData(id: 12, title: "программирование", lessons: [.programming], teachingTypes: [.online], image: Asset.menAvatar.image, price: 400, status: .active),
            AdvertisementData(id: 13, title: "немецкий", lessons: [.german], teachingTypes: [.online, .offline, .group], image: Asset.womenAvatar.image, price: 370, status: .inactive),
            AdvertisementData(id: 14, title: "программирование", lessons: [.programming, .math], teachingTypes: [.online], image: Asset.lessonImage2.image, price: 300, status: .active),
            //            AdvertisementData(id: 15, lessons: [.math, .programming], teachingTypes: [.online], image: Asset.lessonImage2.image, price: 340, status: .active),
            //            AdvertisementData(id: 16, lessons: [.programming], teachingTypes: [.online], image: Asset.lessonImage2.image, price: 400, status: .inactive),
            //            AdvertisementData(id: 17, lessons: [.history], teachingTypes: [.offline, .group], image: Asset.lessonImage1.image, price: 900, status: .active),
            //            AdvertisementData(id: 18, lessons: [.german], teachingTypes: [.offline, .individual], image: Asset.lessonImage1.image, price: 500, status: .active),
            //            AdvertisementData(id: 19, lessons: [.geometry, .math], teachingTypes: [.online, .individual], image: Asset.lessonImage2.image, price: 300, status: .active),
            //            AdvertisementData(id: 110, lessons: [.programming, .biology, .chemistry], teachingTypes: [.online], image: Asset.lessonImage2.image, price: 800, status: .inactive)
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
            //            TutorData(name: "Курманжан Жумабеков", image: Asset.womenAvatar.image ,lessons: [.german, .english, .russian]),
            //            TutorData(name: "Лейла Джекшеналиева", image: Asset.avatarImg.image ,lessons: [.math]),
            //            TutorData(name: "Мирбек Турсунов ", image: Asset.prof.image ,lessons: [.kyrgyzLiterature, .kyrgyz]),
            //            TutorData(name: "Нургуль Каримова", image: Asset.prof1.image ,lessons: [.turkish]),
            //            TutorData(name: "Алексей Ромашенко", image: Asset.menAvatar.image ,lessons: [.programming]),
        ]
        return tutors
    }
}
