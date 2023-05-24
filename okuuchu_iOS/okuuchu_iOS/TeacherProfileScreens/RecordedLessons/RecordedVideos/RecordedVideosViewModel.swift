
import UIKit

//MARK: - Protocols

protocol RecordedVideosViewModelInput{
    var coordinator: RecordedVideosCoordinator? { get set }
    var output: RecordedVideosViewModelOutput? { get set }
    var subject: Lesson? { get set }
    
    func subjectItemTapped(at index: Int)
    func getRecordedVideosFromModel()
    func addButtonTapped()
    func deleteButtonTapped()
    func performSearch(with text: String)
    func selectedVideo(at index: Int)
    func viewDidDisappear()
}

protocol RecordedVideosViewModelOutput: AnyObject {
    func customizeOutput(with videos: [TitleSubtitleViewModel])
}
//MARK: - Class

final class RecordedVideosViewModel: NSObject {
    var coordinator: RecordedVideosCoordinator?
    weak var output: RecordedVideosViewModelOutput? {
        didSet{
            prepareAndSendDataToOutput()
        }
    }
    var subject: Lesson?
    private var allVideos: [RecordedVideo] = []
    private var videos: [RecordedVideo] = []
    private var selectedVideos: [RecordedVideo] = []
}


//MARK: - Extension

extension RecordedVideosViewModel: RecordedVideosViewModelInput {
//    func subjectItemTapped(at index: Int) {
//        <#code#>
//    }
    
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
        if let link = videos[index].link {
            guard let url = URL(string: link) else { return }
            coordinator?.startSafari(with: url)
        }
    }
    
    func addButtonTapped() {
        if let subject = subject {
            coordinator?.startAddVideo(for: subject)
        }
    }
    
    func deleteButtonTapped() {
        for selectedVideo in selectedVideos{
            for (i, video) in allVideos.enumerated() {
                if selectedVideo.id == video.id {
                    allVideos.remove(at: i)
                    break
                }
            }
        }
        selectedVideos.removeAll()
        filterVideos()
        prepareAndSendDataToOutput()

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
    
    func selectedVideo(at index: Int) {
        let selectedVideo = videos[index]
        for (i, video) in selectedVideos.enumerated() {
            if video.id == selectedVideo.id {
                selectedVideos.remove(at: i)
                return
            }
        }
        selectedVideos.append(selectedVideo)
    }
}

extension RecordedVideosViewModel {
    
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
