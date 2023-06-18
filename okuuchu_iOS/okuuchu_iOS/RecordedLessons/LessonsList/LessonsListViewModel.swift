
import Foundation

//MARK: - Protocols
protocol LessonsListViewModelInput{
    var coordinator: LessonsListCoordinator? { get set }
    var output: LessonsLisViewModelOutput? { get set }
    var lessons: [Lesson]? { get set }
    var isEditingMode: Bool? { get set }
    
    func manageLessons()
    func subjectItemTapped(at index: Int)
    func viewDidDisappear()
}

protocol LessonsLisViewModelOutput: AnyObject {
    func customizeOutput(with lessons: [Lesson])
}


//MARK: - Class

final class LessonsListViewModel{
    var coordinator: LessonsListCoordinator?
    weak var output: LessonsLisViewModelOutput? {
        didSet{
            if let lessons = lessons {
                output?.customizeOutput(with: lessons)
            }
        }
    }
    var isEditingMode: Bool?
    var lessons: [Lesson]?
    private var isTabbarController: Bool = false
}


//MARK: - Extension

extension LessonsListViewModel: LessonsListViewModelInput{
    func manageLessons() {
        if lessons == nil {
            lessons = [
                .math,
                .chemistry,
                .biology,
                .physics,
                .english,
                .russian,
                .german,
                .geometry,
                .kyrgyz,
                .turkish,
                .programming,
                .russianLiterature,
                .kyrgyzLiterature,
                .history,
                .geography
            ]
            
            isTabbarController = true
            output?.customizeOutput(with: lessons ?? [])
            
        } else {
            if let lessons = lessons {
                output?.customizeOutput(with: lessons)
            }
        }
    }
    
    func subjectItemTapped(at index: Int) {
        guard let lessons = lessons else { return }
        let subject = lessons[index]
        if isTabbarController {
            coordinator?.startVideoList(for: subject)
        } else {
            coordinator?.startRecordedVideos(for: subject, id: 1, isEditingMode: isEditingMode ?? false)
        }
    }
    
    func viewDidDisappear(){
        coordinator?.didFinish()
    }
}

