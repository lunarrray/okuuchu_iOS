
import UIKit

final class TeacherProfileController: VMController<TeacherProfilePresentable, TeacherProfileViewModelInput> {
    
    //MARK: - Properties
    
    private var tableviewManager: TeacherProfileTableViewManager?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableviewManager = TeacherProfileTableViewManager()
        
        content.tableView.delegate = tableviewManager
        content.tableView.dataSource = tableviewManager
        
        tableviewManager?.delegate = self
        viewModel.getDataFromModel()
        
    }
    
    //MARK: - Override methods
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfigureActions() {
        
    }
}

//MARK: - Extension

extension TeacherProfileController: TeacherProfileTableViewDelegate {
    func selectedMenuItem(_ menuItem: Menu) {
        viewModel.menuItemTapped(menuItem)
    }
}

extension TeacherProfileController: TeacherProfileViewModelOutput{
    func customizeOutput(name: String, image: UIImage, description: String, lessons: String, rating: Double) {
        content.setTutorData(name: name, image: image, description: description, lessons: lessons, rating: rating)
    }

}
