
import UIKit

class TutorData {
    var id: Int?
    var name: String?
    var image: UIImage?
    var description: String?
    var education: String?
    var dateOfBirth: Date?
    var phoneNumber: String?
    var whatsappNumber: String?
    var telegramNic: String?
    var workExperience: String?
    var location: Location?
    var teachingLanguages: [TeachingLanguage]?
    var lessons: [Lesson]?
    var recordedVideos: [RecordedVideo]?
    var reviews: [ReviewData]?
    
    init(id: Int? = nil, name: String? = nil, image: UIImage? = nil, description: String? = nil, education: String? = nil, dateOfBirth: Date? = nil, phoneNumber: String? = nil, whatsappNumber: String? = nil, telegramNic: String? = nil, workExperience: String? = nil, location: Location? = nil, teachingLanguages: [TeachingLanguage]? = nil, lessons: [Lesson]? = nil, recordedVideo: [RecordedVideo]? = nil, reviews: [ReviewData]? = nil) {
        self.id = id
        self.name = name
        self.image = image
        self.description = description
        self.education = education
        self.dateOfBirth = dateOfBirth
        self.phoneNumber = phoneNumber
        self.whatsappNumber = whatsappNumber
        self.telegramNic = telegramNic
        self.workExperience = workExperience
        self.location = location
        self.teachingLanguages = teachingLanguages
        self.lessons = lessons
        self.reviews = reviews
    }
    
    func countRating() -> Double {
        guard let reviews = reviews else { return 0.0 }
        var sum: Double = 0.0
        for review in reviews {
            sum += review.assessment ?? 0.0
        }
        return sum / Double(reviews.count)
    }
    
    func convertLessonsToString() -> String {
        guard let lessons =  lessons else { return "" }
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
}

class RecordedVideo{
    var id: Int?
    var tutorID: Int?
    var title: String?
    var description: String?
    var link: String?
    var subject: Lesson?
    
    init(id: Int? = nil, tutorID: Int? = nil, title: String? = nil, description: String? = nil, link: String? = nil, subject: Lesson? = nil) {
        self.id = id
        self.tutorID = tutorID
        self.title = title
        self.description = description
        self.link = link
        self.subject = subject
    }
}

class ReviewData {
    var reviewer: User?
    var assessment: Double?
    var reviewText: String?
    
    init(reviewer: User? = nil, assessment: Double? = nil, reviewText: String? = nil) {
        self.reviewer = reviewer
        self.assessment = assessment
        self.reviewText = reviewText
    }
    
}
