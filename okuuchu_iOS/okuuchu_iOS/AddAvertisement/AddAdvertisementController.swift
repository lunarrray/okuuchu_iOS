
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
    }
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfigureActions() {
        
    }
}

//MARK: - Extension

extension AddAdvertisementController: AddAdvertisementViewModelOutput {
    func customizeOutput() {
        
    }
}
