

import UIKit

class SavedAdsController: VMController<SavedAdsPresesntable, SavedAdsViewModelInput> {
   
    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Override methods
    
    override func onConfigureController() {
        navigationItem.title = "Сохраненные обьявления"
    }
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfigureActions() {
        
    }

}

//MARK: - Extension

extension SavedAdsController: SavedAdsViewModelOutput {
    func customizeOutput() {
        
    }
}
