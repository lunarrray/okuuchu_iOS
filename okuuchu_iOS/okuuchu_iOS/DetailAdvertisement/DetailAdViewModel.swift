
import UIKit

//MARK: - Protocols

protocol DetailAdViewModelInput {
    var coordinator: DetailAdCoordinator? { get set }
    var output: DetailAdViewModelOutput? { get set }
    var advertisement: AdvertisementData? { get set }
    
    func viewDidDisappear()
    func prepareData()
    func callTutor()
    func whatsappTutor()
    func telegramTutor()
}

protocol DetailAdViewModelOutput: NSObject {
    func customizeOutput(detailData: [TitleSubtitleViewModel], image: UIImage, priceText: String, titleText: String, tutorText: String, tutorImage: UIImage, descriptionText: String)
}

//MARK: - Class

final class DetailAdViewModel {
    var coordinator: DetailAdCoordinator?
    weak var output: DetailAdViewModelOutput? {
        didSet {
            sendPreparedDataToOutput()
        }
    }
    var advertisement: AdvertisementData?
    private var titleSubtitleViewModel = [TitleSubtitleViewModel]()
}

//MARK: - Extension

extension DetailAdViewModel: DetailAdViewModelInput {
    func viewDidDisappear(){
        coordinator?.didFinish()
    }
    
    func prepareData() {
        if let subject = advertisement?.convertLessonsToString() {
            if subject != ""{
                let titleSubtitleData = TitleSubtitleViewModel(title: "Предмет", subtitle: subject)
                titleSubtitleViewModel.append(titleSubtitleData)
            }
        }
        
        if let language = advertisement?.convertLanguagesToString() {
            if language != "" {
                let titleSubtitleData = TitleSubtitleViewModel(title: "Язык преподавания", subtitle: language)
                titleSubtitleViewModel.append(titleSubtitleData)
            }
        }
        
        if let location = advertisement?.location?.title {
            let titleSubtitleData = TitleSubtitleViewModel(title: "Местоположение", subtitle: location)
            titleSubtitleViewModel.append(titleSubtitleData)
        }
        
        if let teachingType = advertisement?.convertTeachingTypesToString() {
            if teachingType != "" {
                let titleSubtitleData = TitleSubtitleViewModel(title: "Тип обучения", subtitle: teachingType)
                titleSubtitleViewModel.append(titleSubtitleData)
            }
        }
        
        sendPreparedDataToOutput()
    }
    
    func callTutor() {
        if let phone = advertisement?.tutor?.phoneNumber{
            let path = "tel://\(phone)"
            openLink(path)
        }
    }
    
    func whatsappTutor() {
        if let whatsappNumber = advertisement?.whatsappNumber{
            
            if let url = URL(string: "https://api.whatsapp.com/send?phone=\(whatsappNumber)") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Handle error, unable to create URL
            }
        }
    }
    
    func telegramTutor() {
        if let tgUser = advertisement?.telegramNic{
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

extension DetailAdViewModel {
    private func sendPreparedDataToOutput(){
        guard let image = advertisement?.image, let price = advertisement?.getPrice(), let title = advertisement?.title, let tutor = advertisement?.tutor?.name, let tutorImage = advertisement?.tutor?.image, let description = advertisement?.description else { return }
        output?.customizeOutput(detailData: titleSubtitleViewModel, image: image, priceText: price, titleText: title, tutorText: tutor, tutorImage: tutorImage, descriptionText: description)
    }
    
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
