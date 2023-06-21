
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
        let tutor = TutorData(name: "Айгерим Асланова", image: Asset.womenAvatar.image, description: "Мен акыркы 5 жылдан бери айылда эмгектенип, мугалимдик кесипти аркаладым. Математика жана физика боюнча студенттерге жардам берем. Окутуунун оптималдуу натыйжаларын камсыз кылуу үчүн ар кандай кызыктуу жана эффективдүү окутуу ыкмаларын колдоном.", education: "Кыргыз-Түрк Манас университети", phoneNumber: "+1234567890", whatsappNumber: "+996704304786", telegramNic: "Kerimkullova", workExperience: "6 жыл", location: .chui, teachingLanguages: [.russian, .english], lessons: [.math, .programming], reviews: [
            ReviewData(reviewer: User(name: "Анна Ахматова", image: Asset.womenAvatar.image), assessment: 2, reviewText: "Я училась у этого учителя много лет и могу сказать, что он настоящий профессионал своего дела. Он знает свой предмет вдоль и поперёк и умеет объяснять так, что даже сложные вещи кажутся простыми."),
            ReviewData(reviewer: User(name: "Асанова Айнагуль", image: Asset.womenAvatar.image), assessment: 4, reviewText: "Очень интересные и познавательные уроки. Учитель всегда держит внимание на высоком уровне, старается найти подход к каждому ученику."),
            ReviewData(reviewer: User(name: "Мамбетова Аида", image: Asset.womenAvatar.image), assessment: 5, reviewText: "Прошла годы, а я всё ещё благодарен этому прекрасному учителю. Он сумел внушить мне любовь к предмету, который я до этого не мог ни понять, ни полюбить."),
            ReviewData(reviewer: User(name: "Елена Морозова", image: Asset.womenAvatar.image), assessment: 3.8, reviewText: "Учитель очень терпеливый и добрый человек. Я была не самым усидчивым учеником, но он всегда находил время и терпение, чтобы помочь мне понять материал"),
            ReviewData(reviewer: User(name: "Дмитрий Лебеде", image: Asset.menAvatar.image), assessment: 4, reviewText: "Учитель всегда готов ответить на любой вопрос и помочь с любой задачей. Его уроки всегда очень понятны и интересны."),
            ReviewData(reviewer: User(name: "Жумабаева Гулназ", image: Asset.womenAvatar.image), assessment: 5, reviewText: "Я учился у этого преподавателя на протяжении многих лет и могу сказать, что он настоящий мастер своего дела. Его уроки всегда были полезными и интересными."),
            ReviewData(reviewer: User(name: "Мамбеталиев Тилек", image: Asset.menAvatar.image), assessment: 3.2, reviewText: "Благодаря этому учителю я начал понимать, что учиться может быть интересно и увлекательно. Его подход к обучению очень индивидуален и всегда ориентирован на потребности каждого ученика."),
            ReviewData(reviewer: User(name: "Байсалова Кадыркул", image: Asset.womenAvatar.image), assessment: 3, reviewText: "Я очень благодарен этому учителю за то, что он помог мне разобраться в том, что я считал раньше совершенно непонятным и сложным."),
            ReviewData(reviewer: User(name: "Наталья Соловьева", image: Asset.womenAvatar.image), assessment: 4.5, reviewText: "Учитель замечательный и очень талантливый преподаватель. Его уроки всегда интересны и познавательны."),
            ReviewData(reviewer: User(name: "Иван Сидоров", image: Asset.menAvatar.image), assessment: 5, reviewText: "Я учился у этого учителя на протяжении нескольких лет и могу сказать, что это было одно из самых полезных и приятных образовательных опытов в моей жизни. Его подход к обучению настолько эффективен, что даже самые сложные темы кажутся легкими.")

        ])
        
        let ads: [AdvertisementData] = [
            AdvertisementData(id: 11, tutor: tutor, title: "Башталгыч класстар үчүн англис тили", lessons: [.english], teachingLanguages: [.russian, .english], teachingTypes: [.online, .offline], location: .chui, description: "Англис тили сабагында студенттер окуу жана угуп түшүнүү жөндөмүн өнүктүрүү үчүн макалалар, кыска аңгемелер жана аудио/видео ресурстар сыяктуу ар кандай оригиналдуу материалдардын кеңири спектрине туш болушат.", image: Asset.mathImage.image, whatsappNumber: "+996704304786", telegramNic: "Kerimkullova", price: 300, status: .active),
            AdvertisementData(id: 12, title: "Программалоо", lessons: [.programming], teachingTypes: [.online], image: Asset.menAvatar.image, price: 400, status: .active),
            AdvertisementData(id: 13, title: "Немис тили", lessons: [.german], teachingTypes: [.online, .offline, .group], image: Asset.womenAvatar.image, price: 370, status: .inactive),
            AdvertisementData(id: 14, title: "Программалоо", lessons: [.programming, .math], teachingTypes: [.online], image: Asset.lessonImage2.image, price: 300, status: .active),
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
            TutorData(name: "Бакыт Курманбекович", image: Asset.prof.image, description: "Мен англис адабияты жана тил илими боюнча күчтүү билимге ээ, бул мени тилди терең түшүнүүгө жардам берди. Мугалимдик карьерамда мен ар кандай курактагы жана маданий тектеги студенттер менен иштөөдөн ырахат алдым.", education: "Lörem ipsum klimatmat fibid tisos, supöning retopi. Geodögisk", phoneNumber: "+1234567890", whatsappNumber: "+996704304786", telegramNic: "Kerimkullova", workExperience: "6 лет", location: .chui, teachingLanguages: [.russian, .english], lessons: [.math, .programming], reviews: [
                ReviewData(reviewer: User(name: "Анна Ахматова", image: Asset.womenAvatar.image), assessment: 3.2, reviewText: "Я училась у этого учителя много лет и могу сказать, что он настоящий профессионал своего дела. Он знает свой предмет вдоль и поперёк и умеет объяснять так, что даже сложные вещи кажутся простыми."),
                ReviewData(reviewer: User(name: "Асанова Айнагуль", image: Asset.womenAvatar.image), assessment: 4, reviewText: "Очень интересные и познавательные уроки. Учитель всегда держит внимание на высоком уровне, старается найти подход к каждому ученику."),
                ReviewData(reviewer: User(name: "Мамбетова Аида", image: Asset.womenAvatar.image), assessment: 5, reviewText: "Прошла годы, а я всё ещё благодарен этому прекрасному учителю. Он сумел внушить мне любовь к предмету, который я до этого не мог ни понять, ни полюбить."),
                ReviewData(reviewer: User(name: "Елена Морозова", image: Asset.womenAvatar.image), assessment: 3.8, reviewText: "Учитель очень терпеливый и добрый человек. Я была не самым усидчивым учеником, но он всегда находил время и терпение, чтобы помочь мне понять материал"),
                ReviewData(reviewer: User(name: "Дмитрий Лебеде", image: Asset.menAvatar.image), assessment: 4, reviewText: "Учитель всегда готов ответить на любой вопрос и помочь с любой задачей. Его уроки всегда очень понятны и интересны."),
                ReviewData(reviewer: User(name: "Жумабаева Гулназ", image: Asset.womenAvatar.image), assessment: 5, reviewText: "Я учился у этого преподавателя на протяжении многих лет и могу сказать, что он настоящий мастер своего дела. Его уроки всегда были полезными и интересными."),
                ReviewData(reviewer: User(name: "Мамбеталиев Тилек", image: Asset.menAvatar.image), assessment: 3.2, reviewText: "Благодаря этому учителю я начал понимать, что учиться может быть интересно и увлекательно. Его подход к обучению очень индивидуален и всегда ориентирован на потребности каждого ученика."),
                ReviewData(reviewer: User(name: "Байсалова Кадыркул", image: Asset.womenAvatar.image), assessment: 3, reviewText: "Я очень благодарен этому учителю за то, что он помог мне разобраться в том, что я считал раньше совершенно непонятным и сложным."),
                ReviewData(reviewer: User(name: "Наталья Соловьева", image: Asset.womenAvatar.image), assessment: 4.5, reviewText: "Учитель замечательный и очень талантливый преподаватель. Его уроки всегда интересны и познавательны."),
                ReviewData(reviewer: User(name: "Иван Сидоров", image: Asset.menAvatar.image), assessment: 5, reviewText: "Я учился у этого учителя на протяжении нескольких лет и могу сказать, что это было одно из самых полезных и приятных образовательных опытов в моей жизни. Его подход к обучению настолько эффективен, что даже самые сложные темы кажутся легкими.")

            ]),
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
