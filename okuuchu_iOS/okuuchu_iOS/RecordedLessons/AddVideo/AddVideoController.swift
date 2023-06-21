
import UIKit

class AddVideoController: VMController<AddVideoPresentable, AddVideoViewModelInput> {
    
    //MARK: - Properties
    
    private var tableViewManager: AddVideoTableViewManager?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewManager = AddVideoTableViewManager()
        
        content.tableView.dataSource = tableViewManager
        content.tableView.delegate = tableViewManager
        
        tableViewManager?.delegate = self
        viewModel.prepareDataForOutput()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }

    //MARK: - Override methods
    
    override func onConfigureController() {
        navigationItem.title = "Видео кошуу"
        navigationItem.leftBarButtonItem = content.navigation.cancelButton
    }
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfigureActions() {
        content.handleCancelButtonTapAction = viewModel.cancelAddingVideo
        content.handleAddButtonTapAction = viewModel.addVideo
    }

}

//MARK: - Extension

extension AddVideoController:  AddVideoViewModelOutput {
    func customizeOutput(with data: [TitleSubtitleViewModel]) {
        tableViewManager?.setTableViewData(data, tableView: content.tableView)
    }
}

extension AddVideoController: AddVideoTableViewDelegate {
    func updateCell(for indexPath: IndexPath, subtitle: String){
        let index = indexPath.row
        viewModel.updateCell(for: index, subtitle: subtitle)
    }
}

