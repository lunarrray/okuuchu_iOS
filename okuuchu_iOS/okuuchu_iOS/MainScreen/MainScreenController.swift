
import UIKit

class MainScreenController: VMController<MainScreenPresentable, MainScreenViewModelInput> {
    
    //MARK: - Properties

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Override methods

    override func onConfigureController() {

    }
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfigureActions() {
        
    }
}

//MARK: - Extension

extension MainScreenController: MainScreenViewModelOutput {
    func customizeOutput() {
        
    }
}
