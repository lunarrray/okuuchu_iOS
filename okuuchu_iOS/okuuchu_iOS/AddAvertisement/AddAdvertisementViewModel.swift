
import UIKit

//MARK: - Protocols

protocol AddAdvertisementViewModelInput{
    var coordinator: AddAdvertisementCoordinator? { get set }
    var output: AddAdvertisementViewModelOutput? { get set }
    var isInTabBar: Bool? { get set }
    
    func cancelAddingVideo()
    func viewDidDisappear()
    func setAdvertisement()
    func setLocation(_ locationString: String)
    func selected(item: String, for selection: Selection)
    func updateCell(for index: Int, subtitle: String)
    func addAdvertisement()
    func clearData(for selection: Selection)
}

protocol AddAdvertisementViewModelOutput {
    func customizeOutput(with advertisementData: [TitleSubtitleViewModel], image: TitleSubtitleViewModel, activeTabBar: Bool)
    func choseLocation(_ locations: [Location])
    func selectItems(from items: [String], selection: Selection)
    func setImage(image: TitleSubtitleViewModel)
    
}

//MARK: - Class
class AddAdvertisementViewModel {
    var coordinator: AddAdvertisementCoordinator?
    var output: AddAdvertisementViewModelOutput? 
    
    private var advertisemenTitleSubtitle: [TitleSubtitleViewModel] = []
    private var advertisementData: AdvertisementData = .init()
    private var advertisementImage: TitleSubtitleViewModel = .init()
    var isInTabBar: Bool?
}


//MARK: - Extension

extension AddAdvertisementViewModel: AddAdvertisementViewModelInput{
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func cancelAddingVideo() {
        coordinator?.didFinish()
    }
    
    func setAdvertisement() {
        advertisementImage = TitleSubtitleViewModel(image: advertisementData.image, onCellUpdate: selectImage)
        advertisemenTitleSubtitle =   [
            TitleSubtitleViewModel(title: "Тема", subtitle: advertisementData.title),
            TitleSubtitleViewModel(title: "Маалымат", subtitle: advertisementData.description),
            TitleSubtitleViewModel(title: "Баасы", subtitle: advertisementData.price, subTextType: .decimal),
            TitleSubtitleViewModel(title: "Сабактар", subtitle: advertisementData.convertLessonsToString(), subTextType: .selectingSeveral, onCellUpdate: selectSubjects),
            TitleSubtitleViewModel(title: "Окутуу тили", subtitle: advertisementData.convertLanguagesToString(), subTextType: .selectingSeveral, onCellUpdate: selectLanguages),
            TitleSubtitleViewModel(title: "Окутуу түрү", subtitle: advertisementData.convertTeachingTypesToString(), subTextType: .selectingSeveral, onCellUpdate: selectTeachingType),
            TitleSubtitleViewModel(title: "Жайгашкан жери", subtitle: advertisementData.location?.title, subTextType: .selectingOne, onCellUpdate: selectLocation)
        ]
        
        guard let isInTabBar = isInTabBar else { return }
        output?.customizeOutput(with: advertisemenTitleSubtitle, image: advertisementImage, activeTabBar: isInTabBar)
    }
    
    func setLocation(_ locationString: String) {
        let locations = Location.allCases
        for location in locations {
            if location.title == locationString {
                advertisementData.location = location
                setAdvertisement()
                break
            }
        }
    }
    
    func selected(item: String, for selection: Selection) {
        switch selection {
        case .lesson:
            let allLessons = Lesson.allCases
            for lesson in allLessons {
                if lesson.title == item {
                    if var lessons = advertisementData.lessons {
                        if !lessons.contains(lesson){
                            lessons.append(lesson)
                            advertisementData.lessons = lessons
                        }
                    } else {
                        advertisementData.lessons = [lesson]
                    }
                    break
                }
            }
            
        case .teachingType:
            let allTypes = TeachingType.allCases
            for type in allTypes {
                if type.title == item {
                    if var teachingTypes = advertisementData.teachingTypes {
                        if !teachingTypes.contains(type){
                            teachingTypes.append(type)
                            advertisementData.teachingTypes = teachingTypes
                        }
                    } else {
                        advertisementData.teachingTypes = [type]
                    }
                    break
                }
            }
            
        case .languages:
            let allLanguages = TeachingLanguage.allCases
            for language in allLanguages {
                if language.title == item {
                    if var advertisementLanguages = advertisementData.teachingLanguages {
                        if !advertisementLanguages.contains(language) {
                            advertisementLanguages.append(language)
                            advertisementData.teachingLanguages = advertisementLanguages
                        }
                    } else {
                        advertisementData.teachingLanguages = [language]
                    }
                    break
                }
            }
    
        }
        setAdvertisement()

    }
    
    func updateCell(for index: Int, subtitle: String) {
        let cellViewModel = advertisemenTitleSubtitle[index]
        cellViewModel.update(subtitle)
       
        if index == 0{
            advertisementData.title = subtitle
        } else if index == 1 {
            advertisementData.description = subtitle
        } else if index == 2 {
            advertisementData.price = subtitle
        }        
    }
    
    func addAdvertisement() {
        print(advertisementData.title)
        print(advertisementData.description)
        print(advertisementData.convertLessonsToString())
        print(advertisementData.convertTeachingTypesToString())
        print(advertisementData.convertLanguagesToString())
        print(advertisementData.price)
        print(advertisementData.location)

        guard let isInTabBar = isInTabBar else { return }
        if isInTabBar{
            coordinator?.showAlert()
        } else {
            coordinator?.didFinish()
        }

    }
    
    func clearData(for selection: Selection) {
        switch selection {
        case .lesson:
            advertisementData.lessons = []
        case .teachingType:
            advertisementData.teachingTypes = []
        case .languages:
            advertisementData.teachingLanguages = []
        }
        
        setAdvertisement()
    }
}


extension AddAdvertisementViewModel {
    private func selectSubjects() -> Void{
        let allSubjects = Lesson.allCases
        var items = [String]()
        for subject in allSubjects {
            items.append(subject.title)
        }
        
        output?.selectItems(from: items, selection: .lesson)
    }
    
    private func selectLanguages() -> Void{
        let allLanguages = TeachingLanguage.allCases
        var items = [String]()
        for language in allLanguages {
            items.append(language.title)
        }
        
        output?.selectItems(from: items, selection: .languages)
    }
    
    private func selectTeachingType() -> Void{
        let allTeachingTypes = TeachingType.allCases
        var items = [String]()
        for type in allTeachingTypes {
            items.append(type.title)
        }
        
        output?.selectItems(from: items, selection: .teachingType)
    }
    
    private func selectLocation() -> Void{
        let locations: [Location] = [.batken, .chui, .issykKul, .jalalAbad, .naryn, .osh, .talas]
        output?.choseLocation(locations)
    }
    
    private func selectImage() -> Void{
        print("selecting image")
        
        guard let isInTabBar = isInTabBar else { return }
        if isInTabBar{
            coordinator?.showImagePickerForTab{ image in
                self.advertisementImage.update(image)
                self.advertisementData.image = image
                self.output?.setImage(image: self.advertisementImage)
            }
        } else {
            coordinator?.showImagePicker{ image in
                self.advertisementImage.update(image)
                self.advertisementData.image = image
                self.output?.setImage(image: self.advertisementImage)
            }
        }
    }
}

enum Selection {
    case lesson, teachingType, languages
    var title: String {
        switch self {
        case .lesson:
            return "Сабак кошуу"
        case .teachingType:
            return "Окутуу түрүн кошуу"
        case .languages:
            return "Окутуу тилин кошуу"
        }
    }
}
