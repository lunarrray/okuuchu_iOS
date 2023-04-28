
import Foundation

final class TeacherProfileController: VMController<TeacherProfilePresentable, TeacherProfileViewModelInput> {
    
    //MARK: - Properties
    
    private var tableviewManager: TeacherProfileTableViewManager?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableviewManager = TeacherProfileTableViewManager()
        
        content.tableView.delegate = tableviewManager
        content.tableView.dataSource = tableviewManager
        
        viewModel.getTableViewDataFromModel()
        tableviewManager?.delegate = self
        
    }
    
    //MARK: - Override methods
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfiugureActions() {
        
    }
}

//MARK: - Extension

extension TeacherProfileController: TeacherProfileTableViewDelegate {
    func selectedCell() {
        viewModel.cellTapped()
    }
}

extension TeacherProfileController: TeacherProfileViewModelOutput{
    func customizeOutput(with cellData: [CellData]) {
        tableviewManager?.setData(cellData, tableView: content.tableView)
    }
}
