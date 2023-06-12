
import UIKit

final class DetailAdController: VMController<DetailAdPresentable, DetailAdViewModelInput> {
    
    //MARK: - Properties
    
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            viewModel.viewDidDisappear()
        }
    }

    
    //MARK: - Override methods

    override func onConfigureController() {
        navigationItem.rightBarButtonItem = content.navigation.saveButton
    }
    
    override func onConfigureViewModel() {
        viewModel.output = self
    }
    
    override func onConfigureActions() {
        
    }
}

//MARK: - Extension

extension DetailAdController: DetailAdViewModelOutput {
    func customizeOutput() {
        
    }
}
