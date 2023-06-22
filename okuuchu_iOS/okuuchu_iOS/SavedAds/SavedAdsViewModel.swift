
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
        
        let tutor1 = TutorData(name: "Айгерим Асланова", image: Asset.womenAvatar.image, description: "Мен акыркы 5 жылдан бери айылда эмгектенип, мугалимдик кесипти аркаладым. Математика жана физика боюнча студенттерге жардам берем. Окутуунун оптималдуу натыйжаларын камсыз кылуу үчүн ар кандай кызыктуу жана эффективдүү окутуу ыкмаларын колдоном.", education: "Кыргыз-Түрк Манас университети", phoneNumber: "+1234567890", whatsappNumber: "+996704304786", telegramNic: "Kerimkullova", workExperience: "6 жыл", location: .chui, teachingLanguages: [.russian, .english], lessons: [.math, .programming], reviews: [
            ReviewData(reviewer: User(name: "Анна Ахматова", image: Asset.womenAvatar.image), assessment: 2, reviewText: "Я училась у этого учителя много лет и могу сказать, что он настоящий профессионал своего дела. Он знает свой предмет вдоль и поперёк и умеет объяснять так, что даже сложные вещи кажутся простыми."),
            ReviewData(reviewer: User(name: "Асанова Айнагуль", image: Asset.womenAvatar.image), assessment: 4, reviewText: "Очень интересные и познавательные уроки. Учитель всегда держит внимание на высоком уровне, старается найти подход к каждому ученику."),
            ReviewData(reviewer: User(name: "Мамбетова Аида", image: Asset.womenAvatar.image), assessment: 5, reviewText: "Прошла годы, а я всё ещё благодарен этому прекрасному учителю. Он сумел внушить мне любовь к предмету, который я до этого не мог ни понять, ни полюбить."),
            ReviewData(reviewer: User(name: "Елена Морозова", image: Asset.womenAvatar.image), assessment: 3.8, reviewText: "Учитель очень терпеливый и добрый человек. Я была не самым усидчивым учеником, но он всегда находил время и терпение, чтобы помочь мне понять материал"),
            ReviewData(reviewer: User(name: "Дмитрий Лебеде", image: Asset.menAvatar.image), assessment: 4, reviewText: "Учитель всегда готов ответить на любой вопрос и помочь с любой задачей. Его уроки всегда очень понятны и интересны."),
            ReviewData(reviewer: User(name: "Жумабаева Гулназ", image: Asset.womenAvatar.image), assessment: 5, reviewText: "Я учился у этого преподавателя на протяжении многих лет и могу сказать, что он настоящий мастер своего дела. Его уроки всегда были полезными и интересными."),
            ReviewData(reviewer: User(name: "Мамбеталиев Тилек", image: Asset.menAvatar.image), assessment: 3.2, reviewText: "Благодаря этому учителю я начал понимать, что учиться может быть интересно и увлекательно. Его подход к обучению очень индивидуален и всегда ориентирован на потребности каждого ученика."),
            ReviewData(reviewer: User(name: "Байсалова Кадыркул", image: Asset.womenAvatar.image), assessment: 3, reviewText: "Я очень благодарен этому учителю за то, что он помог мне разобраться в том, что я считал раньше совершенно непонятным и сложным."),
            ReviewData(reviewer: User(name: "Наталья Соловьева", image: Asset.womenAvatar.image), assessment: 4.5, reviewText: "Учитель замечательный и очень талантливый преподаватель. Его уроки всегда интересны и познавательны."),
            ReviewData(reviewer: User(name: "Иван Сидоров", image: Asset.menAvatar.image), assessment: 5, reviewText: "Я учился у этого учителя на протяжении нескольких лет и могу сказать, что это было одно из самых полезных и приятных образовательных опытов в моей жизни. Его подход к обучению настолько эффективен, что даже самые сложные темы кажутся легкими.")])
        adsData = [
            AdvertisementData(id: 23, tutor: tutor1, title: Lesson.german.title, lessons: [.german], teachingLanguages: [.kyrgyz, .english], teachingTypes: [.group, .offline], location: .naryn, description: "Deutsch (German) ist eine faszinierende Sprache, die von über 100 Millionen Menschen weltweit gesprochen wird. Es ist die offizielle Sprache in Deutschland, Österreich, der Schweiz und vielen ander", image: Asset.study4.image, whatsappNumber: "+996704304786", telegramNic: "Kerimkullova", price: "1000", status: .active),
            AdvertisementData(id: 11, title: "Математика для школьников", lessons: [.math], teachingTypes: [.online], image: Asset.lessonImage1.image, price: "300", status: .active),
            AdvertisementData(id: 12, title: "Python для детей, программирование", lessons: [.programming], teachingTypes: [.online], image: Asset.menAvatar.image, price: "400", status: .active),
            AdvertisementData(id: 13, title: "Немецкий", lessons: [.german], teachingTypes: [.online, .offline, .group], image: Asset.womenAvatar.image, price: "370", status: .inactive),
            AdvertisementData(id: 14, title: "Программирование", lessons: [.programming, .math], teachingTypes: [.online], image: Asset.lessonImage2.image, price: "300", status: .active),
            AdvertisementData(id: 15, title: "Программирование и математика", lessons: [.math, .programming], teachingTypes: [.online], image: Asset.lessonImage2.image, price: "340", status: .active),
            AdvertisementData(id: 16, title: "Программирование на C++", lessons: [.programming], teachingTypes: [.online], image: Asset.lessonImage2.image, price: "400", status: .inactive),
            AdvertisementData(id: 17, title: "История за 3 месяца", lessons: [.history], teachingTypes: [.offline, .group], image: Asset.lessonImage1.image, price: "900", status: .active),
            AdvertisementData(id: 18, title: "Немецкий", lessons: [.german], teachingTypes: [.offline, .individual], image: Asset.lessonImage1.image, price: "500", status: .active),
            AdvertisementData(id: 19, title: "Геометрия и математика", lessons: [.geometry, .math], teachingTypes: [.online, .individual], image: Asset.lessonImage2.image, price: "300", status: .active),
            AdvertisementData(id: 110, title: "Биология и химия за 2 месяца", lessons: [.biology, .chemistry], teachingTypes: [.online], image: Asset.lessonImage2.image, price: "800", status: .inactive)
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
            
            guard let image = advertisement.image else { return nil }
            let lessons = advertisement.convertLessonsToString()
            let teachingTypes = advertisement.convertTeachingTypesToString()
            
            let subsubtitle = SubsubtitleViewModel(title: advertisement.getPrice() ?? "", subtitle:  lessons, subsubtitle: teachingTypes, image: image)
            subsubtitleViewModels.append(subsubtitle)
        }
        
        return subsubtitleViewModels
    }
}
