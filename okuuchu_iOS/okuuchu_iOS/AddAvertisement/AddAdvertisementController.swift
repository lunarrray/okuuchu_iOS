
import UIKit

class AddAdvertisementController: VMController<AddAdvertisementPresentable, AddAdvertisementViewModelInput> {
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    //MARK: - Override methods

    override func onConfigureController() {
        navigationItem.title = "Добавить объявление"
        navigationItem.leftBarButtonItem = content.navigation.cancelButton
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
    func customizeOutput() {
        
    }
}