
import UIKit

class AddAdvertisementController: VMController<AddAdvertisementPresentable, AddAdvertisementViewModelInput> {
    
    //MARK: - Properties
    
    private var tableViewManager: AddAdvertisementTableViewManager?
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       tableViewManager = AddAdvertisementTableViewManager()
        content.tableView.dataSource = tableViewManager
        content.tableView.delegate = tableViewManager
        
        viewModel.getDataFromModel()
        tableViewManager?.delegate = self
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if isMovingFromParent {
            viewModel.viewDidDisappear()
        }
    }

    
    //MARK: - Override methods

    override func onConfigureController() {
        navigationItem.title = "Жарнама кошуу"
        navigationItem.leftBarButtonItem = content.navigation.cancelButton
        navigationItem.rightBarButtonItem = content.navigation.addButton
    }
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfigureActions() {
        content.handleCancelButtonTapAction = viewModel.cancelAddingVideo
    }
}

//MARK: - Extension

extension AddAdvertisementController: AddAdvertisementViewModelOutput {
    func customizeOutput(with advertisementData: [TitleSubtitleViewModel]) {
        tableViewManager?.setData(advertisementData, tableView: content.tableView)
    }
}

extension AddAdvertisementController: AddAdvertisementTableViewDelegate {
    
}
