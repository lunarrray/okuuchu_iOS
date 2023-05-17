
import UIKit

class TutorData {
    var name: String?
    var image: UIImage?
    var description: String?
    var education: String?
    var dateOfBirth: Date?
    var whatsappNumber: String?
    var telegramNumber: String?
    var workExperience: String?
    var location: Location?
    var teachingLanguages: [TeachingLanguage]?
    var lessons: [Lesson]?
    
    init(name: String? = nil, image: UIImage? = nil, description: String? = nil, education: String? = nil, dateOfBirth: Date? = nil, whatsappNumber: String? = nil, telegramNumber: String? = nil, workExperience: String? = nil, location: Location? = nil, teachingLanguages: [TeachingLanguage]? = nil, lessons: [Lesson]? = nil) {
        self.name = name
        self.image = image
        self.description = description
        self.education = education
        self.dateOfBirth = dateOfBirth
        self.whatsappNumber = whatsappNumber
        self.telegramNumber = telegramNumber
        self.workExperience = workExperience
        self.location = location
        self.teachingLanguages = teachingLanguages
        self.lessons = lessons
    }
}
