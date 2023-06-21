
import Foundation

//MARK: - Protocols

protocol VideoInfoViewModelInput {
    var coordinator: VideoInfoCoordinator? { get set }
    var output: VideoInfoViewModelOutput? { get set }
    var videoData: RecordedVideo? { get set }
    
    func  viewDidDisappear()
    func getDataFromModel()
    func watchVideo()
    func viewTutor()
}

protocol VideoInfoViewModelOutput: AnyObject {
    func customizeOutput(with data: [TitleSubtitleViewModel])
}
//MARK: - Class

final class VideoInfoViewModel {
    var coordinator: VideoInfoCoordinator?
    weak var output: VideoInfoViewModelOutput?{
        didSet{
            output?.customizeOutput(with: titleSubtitleData)
        }
    }
    
    var videoData: RecordedVideo?
    var videoTutor: TutorData = TutorData()
    private var titleSubtitleData: [TitleSubtitleViewModel] = []

}


//MARK: - Extension

extension VideoInfoViewModel: VideoInfoViewModelInput {
    func viewDidDisappear(){
        coordinator?.didFinish()
    }
    
    func getDataFromModel() {
        videoTutor = TutorData(id: 122, name: "Анна Львович",  image: Asset.womenAvatar.image, description: "Lörem ipsum misk stenoling. Semir. Nes boomer härgjord. Lipoktiga reledes förutom behånde egodyk ifall reamir. ", education: "Кыргызско-Турецкий университет Манас", whatsappNumber: "0990505005", telegramNic: "0990505005", workExperience: "4 года", location: .chui, teachingLanguages: [.russian, .kyrgyz], lessons: [.math, .russian, .physics])
        guard let videoTitle = videoData?.title, let videoDescription = videoData?.description else { return }
        let topic = TitleSubtitleViewModel(title: "Тема", subtitle: videoTitle)
        titleSubtitleData.append(topic)
        let description = TitleSubtitleViewModel(title: "Маалымат", subtitle: videoDescription)
        titleSubtitleData.append(description)
        let tutor = TitleSubtitleViewModel(title: "Окутуучу", subtitle: videoTutor.name)
        titleSubtitleData.append(tutor)
        
        output?.customizeOutput(with: titleSubtitleData)
    }
    
    func watchVideo() {
        if let link = videoData?.link {
            guard let url = URL(string: link) else { return }
            coordinator?.startSafari(with: url)
        }
    }
    
    func viewTutor() {
        coordinator?.startVideoTutor(for: videoTutor)
    }
    
}


