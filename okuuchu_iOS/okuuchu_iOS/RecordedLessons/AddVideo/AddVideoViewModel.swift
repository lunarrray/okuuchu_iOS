
import UIKit

//MARK: - Protocols

protocol AddVideoViewModelInput{
    var coordinator: AddVideoCoordinator? { get set }
    var output: AddVideoViewModelOutput? { get set}
    var subject: Lesson? { get set }
    
    func cancelAddingVideo()
    func prepareDataForOutput()
    func updateCell(for index: Int, subtitle: String)
    func addVideo()
}

protocol AddVideoViewModelOutput: AnyObject {
    func customizeOutput(with data: [TitleSubtitleViewModel])
}

//MARK: - Class

final class AddVideoViewModel {
    var coordinator: AddVideoCoordinator?
    weak var output: AddVideoViewModelOutput? {
        didSet {
            output?.customizeOutput(with: titleSubtitleData)
        }
    }
    private var titleSubtitleData: [TitleSubtitleViewModel] = [
        TitleSubtitleViewModel(title: "Тема", subtitle: ""),
        TitleSubtitleViewModel(title: "Описание", subtitle: ""),
        TitleSubtitleViewModel(title: "Ссылка", subtitle: ""),
    ]
    
    var subject: Lesson?
}

//MARK: - Extension

extension AddVideoViewModel: AddVideoViewModelInput {
    
    func cancelAddingVideo() {
        coordinator?.didFinish()
    }
    
    func prepareDataForOutput() {
        output?.customizeOutput(with: titleSubtitleData)
    }
    
    func updateCell(for index: Int, subtitle: String) {
        let cellViewModel = titleSubtitleData[index]
        cellViewModel.update(subtitle)
    }
    
    func addVideo() {
        for data in titleSubtitleData {
            print("\(data.title!): \(data.subtitle!)")
        }
        
        coordinator?.didFinishAddingVideo()
    }
}
