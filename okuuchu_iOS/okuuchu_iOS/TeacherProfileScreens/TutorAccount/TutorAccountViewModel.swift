
import UIKit

//MARK: - Protocols
protocol TutorAccountViewModelInput {
    var coordinator: TutorAccountCoordinator? { get set }
    var output: TutorAccountViewModelOutput? { get set }
    var tutorData: TutorData? { get set }
    
    func viewDidDisappear()
    func fillData()
    func callTutor()
    func whatsappTutor()
    func telegramTutor()
}

protocol TutorAccountViewModelOutput: AnyObject {
    func customizeOutput(image: UIImage, rating: Double, tutorInfo: [TitleSubtitleViewModel])
}

//MARK: - Class

final class TutorAccountViewModel {
    var coordinator: TutorAccountCoordinator?
    weak var output: TutorAccountViewModelOutput?
    
    var tutorData: TutorData?
}

//MARK: - Extension

extension TutorAccountViewModel: TutorAccountViewModelInput {
    
    func viewDidDisappear(){
        coordinator?.didFinsish()
    }
    
    func fillData() {
        guard let image = tutorData?.image, let rating = tutorData?.countRating() else { return }
        
        var titleAndSubtitles: [TitleSubtitleViewModel] = []
        
        if let descriptionSubtitle = tutorData?.description {
            let description: TitleSubtitleViewModel = .init(title: "О преподавателе", subtitle: descriptionSubtitle)
            titleAndSubtitles.append(description)
        }
        if let educationSubtitle = tutorData?.education {
            let education: TitleSubtitleViewModel = .init(title: "Образование", subtitle: educationSubtitle)
            titleAndSubtitles.append(education)
        }
        if let lessonsSubtitle = tutorData?.convertLessonsToString() {
            let lessons: TitleSubtitleViewModel = .init(title: "Предметы", subtitle: lessonsSubtitle)
            titleAndSubtitles.append(lessons)
        }
        if let languagesSubtitle = tutorData?.convertLessonsToString() {
            let languages: TitleSubtitleViewModel = .init(title: "Языки преподавания", subtitle: languagesSubtitle)
            titleAndSubtitles.append(languages)
        }
        if let experienceSubtitle = tutorData?.workExperience {
            let experience: TitleSubtitleViewModel = .init(title: "Опыт Работы", subtitle: experienceSubtitle)
            titleAndSubtitles.append(experience)
        }
        if let locationSubtitle = tutorData?.location {
            let location: TitleSubtitleViewModel = .init(title: "Местоположение", subtitle: locationSubtitle.title)
            titleAndSubtitles.append(location)
        }
        output?.customizeOutput(image: image, rating: rating, tutorInfo: titleAndSubtitles)
    }
    
    func callTutor() {
        if let phone = tutorData?.phoneNumber{
            let path = "tel://\(phone)"
            openLink(path)
        }
    }
    
    func whatsappTutor() {
        if let whatsappNumber = tutorData?.whatsappNumber{
            
            if let url = URL(string: "https://api.whatsapp.com/send?phone=\(whatsappNumber)") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Handle error, unable to create URL
            }
        }
    }
    
    func telegramTutor() {
        if let tgUser = tutorData?.telegramNic{
            let username = tgUser.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!
            let telegramURL = URL(string: "tg://resolve?domain=\(username)")!
            
            if UIApplication.shared.canOpenURL(telegramURL) {
                UIApplication.shared.open(telegramURL, options: [:], completionHandler: nil)
            } else {
                // Telegram is not installed, handle the error as needed
            }
        }
    }
}


extension TutorAccountViewModel {
    private func openLink(_ path: String) {
        guard let url = URL(string: path),
              UIApplication.shared.canOpenURL(url) else { return }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
