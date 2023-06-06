
import UIKit

//MARK: - Protocols

protocol VideoListViewModelInput{
    var coordinator: VideoListCoordinator? { get set }
    var output: VideoListViewModelOutput? { get set }
    var subject: Lesson? { get set }
    
    func subjectItemTapped(at index: Int)
    func getRecordedVideosFromModel()
    func performSearch(with text: String)
    func viewDidDisappear()
}

protocol VideoListViewModelOutput: AnyObject {
    func customizeOutput(with videos: [TitleSubtitleViewModel])
}
//MARK: - Class

final class VideoListViewModel: NSObject {
    var coordinator: VideoListCoordinator?
    weak var output: VideoListViewModelOutput? {
        didSet{
            prepareAndSendDataToOutput()
        }
    }
    var subject: Lesson?
    private var allVideos: [RecordedVideo] = []
    private var videos: [RecordedVideo] = []
}


//MARK: - Extension

extension VideoListViewModel: VideoListViewModelInput {
    
    func getRecordedVideosFromModel() {
        allVideos = [
            RecordedVideo(id: 110, title: "geometry", description: "Приложение разработано для удобного и быстрого поиска подходящих репетиторов и учеников.", link: "https://youtu.be/X85soC5evw0", subject: .geometry),
            RecordedVideo(id: 111, title: "geometry", description: "Изучение основных операций (сложение, вычитание, умножение, деление) и применение их на практике для решения простых математических задач.", subject: .geometry),
            RecordedVideo(id: 112, title: "Арифметика", description: "Изучение основных операций (сложение, вычитание, умножение, деление) и применение их на практике для решения простых математических задач.", link: "https://youtu.be/X85soC5evw0", subject: .math),
            RecordedVideo(id: 113, title: "Десятичные дроби", description: "Изучение записи, сравнения и операций с десятичными дробями, включая сложение, вычитание, умножение и деление. Решение задач, связанных с долями и процентами.", link: "https://youtu.be/X85soC5evw0", subject: .math),
            RecordedVideo(id: 114, title: "Алгебраические выражения", description: "Введение в алгебраические выражения и их упрощение. Решение уравнений и неравенств с одной переменной.", link: "https://youtu.be/X85soC5evw0", subject: .math),
            RecordedVideo(id: 115, title: "Статистика и диаграммы", description: "Сбор, представление и анализ данных в виде диаграмм и таблиц. Расчет среднего значения, медианы и моды. Решение задач на основе статистических данных.", link: "https://youtu.be/X85soC5evw0", subject: .math),
            RecordedVideo(id: 116, title: "Диаграммы", description: "Столбчатая диаграмма, Круговая диаграмма: Линейная диаграмма Кольцевая диаграмма.", link: "https://youtu.be/X85soC5evw0", subject: .math),

            RecordedVideo(id: 117, title: "programming", description: "Приложение разработано для удобного и быстрого поиска подходящих репетиторов и учеников.", subject: .programming),
            RecordedVideo(id: 118, title: "programming", description: "Приложение разработано для удобного и быстрого поиска подходящих репетиторов и учеников.", subject: .programming),
            RecordedVideo(id: 119, title: "physics", description: "Приложение разработано для удобного и быстрого поиска подходящих репетиторов и учеников.", subject: .physics),
            RecordedVideo(id: 120, title: "physics", description: "Приложение разработано для удобного и быстрого поиска подходящих репетиторов и учеников.", subject: .physics),
            RecordedVideo(id: 121, title: "physics", description: "Приложение разработано для удобного и быстрого поиска подходящих репетиторов и учеников.", subject: .physics),
        ]

        filterVideos()
        prepareAndSendDataToOutput()
    }
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func subjectItemTapped(at index: Int) {
        let video = videos[index]
        coordinator?.startVideoInfo(video: video)
    }

    
    func performSearch(with text: String) {
        
        var filteredVideos: [RecordedVideo] = []
        let text = text.lowercased()
        for video in allVideos {
            if video.subject == subject {
                guard let title = video.title?.lowercased(), let descriptipn = video.description?.lowercased() else { return }
                
                if title.contains(text) || descriptipn.contains(text){
                    filteredVideos.append(video)
                }
            }
        }
        
        if !filteredVideos.isEmpty {
            videos = filteredVideos
            prepareAndSendDataToOutput()
        }
    }
}

extension VideoListViewModel {
    
    private func filterVideos(){
        videos.removeAll()
        for allVideo in allVideos {
            if allVideo.subject == subject{
                videos.append(allVideo)
            }
        }
    }
    
    private func prepareAndSendDataToOutput(){
        
        var convertedVideos: [TitleSubtitleViewModel] = []
        for video in videos{
            let data = TitleSubtitleViewModel(title: video.title, subtitle: video.description)
            convertedVideos.append(data)
        }
        output?.customizeOutput(with: convertedVideos)
    }
}
