
import Foundation

//MARK: - Protocols
protocol TeacherProfileViewModelInput {
    var coordinator: TeacherProfileCoordinator? { get set }
    var output: TeacherProfileViewModelOutput? { get set }
    
    func getTableViewDataFromModel()
    func cellTapped()
    
}

protocol TeacherProfileViewModelOutput: AnyObject {
    func customizeOutput(with cellData: [CellData])
}

//MARK: - Class

final class TeacherProfileViewModel {
    var coordinator: TeacherProfileCoordinator?
    weak var output: TeacherProfileViewModelOutput? {
        didSet {
            output?.customizeOutput(with: tableViewData)
        }
    }
    
    private var tableViewData: [CellData] = []
//    [
//        CellData(title: "График"),
//        CellData(title: "Записанные уроки"),
//        CellData(title: "Обновить информацию о себе"),
//        CellData(title: "Обьявления"),
//        CellData(title: "Отзывы"),
//        CellData(title: "Информация")
//    ]
}

//MARK: - Extension

extension TeacherProfileViewModel: TeacherProfileViewModelInput {
    func getTableViewDataFromModel() {
        //asking for tableviewdata to model
        tableViewData =  [
            CellData(title: "График"),
            CellData(title: "Записанные уроки"),
            CellData(title: "Обновить информацию о себе"),
            CellData(title: "Обьявления"),
            CellData(title: "Отзывы"),
            CellData(title: "Информация")
        ]
        
        output?.customizeOutput(with: tableViewData)
    }
    
    func cellTapped() {
        coordinator?.startUpdateTeacherInfo()
    }
}
