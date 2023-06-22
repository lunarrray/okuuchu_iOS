
import UIKit

class AdvertisementData {
    var id: Int?
    var tutor: TutorData?
    var title: String?
    var lessons: [Lesson]?
    var teachingLanguages: [TeachingLanguage]?
    var teachingTypes: [TeachingType]?
    var location: Location?
    var description: String?
    var image: UIImage?
    var whatsappNumber: String?
    var telegramNic: String?
    var price: String?
    var status: ActiveStatus?
    
    init(id: Int? = nil, tutor: TutorData? = nil, title: String? = nil, lessons: [Lesson]? = nil, teachingLanguages: [TeachingLanguage]? = nil, teachingTypes: [TeachingType]? = nil, location: Location? = nil, description: String? = nil, image: UIImage? = nil, whatsappNumber: String? = nil, telegramNic: String? = nil, price: String? = nil, status: ActiveStatus? = nil) {
        self.id = id
        self.tutor = tutor
        self.title = title
        self.lessons = lessons
        self.teachingLanguages = teachingLanguages
        self.teachingTypes = teachingTypes
        self.location = location
        self.description = description
        self.image = image
        self.whatsappNumber = whatsappNumber
        self.telegramNic = telegramNic
        self.price = price
        self.status = status
    }
    
    func convertLessonsToString() -> String {
        guard let lessons = lessons else { return "" }
        var text = ""
        let spacing = ", "
        for (i, lesson) in lessons.enumerated() {
            text += lesson.title
            if i != lessons.count - 1 {
                text += spacing
            }
        }
        return text
    }
    
    func convertTeachingTypesToString() -> String {
        guard let teachingTypes = teachingTypes else { return "" }
        var text = ""
        let spacing = ", "
        for (i, teachingType) in teachingTypes.enumerated() {
            text += teachingType.title
            if i != teachingTypes.count - 1 {
                text += spacing
            }
        }
        
        return text
    }
    
    func convertLanguagesToString() -> String {
        guard let teachingLanguages = teachingLanguages else { return "" }
        var text = ""
        let spacing = ", "
        for (i, language) in teachingLanguages.enumerated() {
            text += language.title
            if i != teachingLanguages.count - 1 {
                text += spacing
            }
        }
        return text
    }
    
    func getPrice() -> String? {
        if let price = price {
            return price + " сом"
        }
        return nil
    }
}
